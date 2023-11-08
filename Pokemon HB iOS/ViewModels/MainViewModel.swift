//
//  MainViewModel.swift
//  Pokemon HB iOS
//
//  Created by Martin Brianto on 08/11/23.
//

import Foundation
import RxSwift

enum MainViewModelState {
    case error(String)
    case loaded
    case loading
}

protocol MainViewModel {
    var cardList: [PokemonCard] { get }
    var searchType: PokemonCardSearchType { get }
    var rxViewState: Observable<MainViewModelState> { get }
    var rxSearchType: Observable<PokemonCardSearchType> { get }
    
    func loadInitialData()
    func searchPokemonCard(_ keyword: String)
    func loadMorePokemonCard()
    func changeSearchType(to: PokemonCardSearchType)
}

final class MainViewModelImpl: MainViewModel {
    
    var cardList: [PokemonCard] = []
    var searchType: PokemonCardSearchType = .name {
        didSet {
            _rxSearchType.onNext(searchType)
        }
    }
    var searchKeyword: String = ""
    
    private let repository: CardSearchRepository
    private var page: Int = 1
    private var pageSize: Int = 0
    private var isLoadingMore = false
    
    private var searchDisposeBag = DisposeBag()
    private var loadMoreDisposeBag = DisposeBag()
    
    init(repository: CardSearchRepository = CardSearchRepositoryImpl()) {
        self.repository = repository
    }
    
    // MARK: - Outputs
    
    private let _rxViewState = PublishSubject<MainViewModelState>()
    var rxViewState: Observable<MainViewModelState> { _rxViewState.asObservable() }
    
    private let _rxSearchType = PublishSubject<PokemonCardSearchType>()
    var rxSearchType: Observable<PokemonCardSearchType> { _rxSearchType.asObservable() }
    
    // MARK: - Inputs
    
    func loadInitialData() {
        page = 1
        _rxViewState.onNext(.loading)
        fetchPokemonCardList("Charizard")
    }
    
    func searchPokemonCard(_ keyword: String) {
        page = 1
        searchKeyword = keyword
        _rxViewState.onNext(.loading)
        fetchPokemonCardList(keyword)
    }
    
    func loadMorePokemonCard() {
        page += 1
        loadMorePokemonCardList()
    }
    
    func changeSearchType(to searchType: PokemonCardSearchType) {
        self.searchType = searchType
    }
    
    // MARK: - Private Methods
    
    private func loadMorePokemonCardList() {
        guard page < pageSize, !isLoadingMore else { return }
        
        loadMoreDisposeBag = DisposeBag()
        isLoadingMore = true
        
        repository.searchCard(searchKeyword: self.searchKeyword, searchType: searchType, page: page)
            .subscribe(onNext: { [weak self] responseData in
                self?.pageSize = responseData.pageSize
                self?.cardList.append(contentsOf: responseData.data)
                self?._rxViewState.onNext(.loaded)
                self?.isLoadingMore = false
            }, onError: { [weak self] error in
                if let error = error as? NetworkError {
                    self?._rxViewState.onNext(.error(error.description))
                } else {
                    self?._rxViewState.onNext(.error(error.localizedDescription))
                }
            })
            .disposed(by: searchDisposeBag)
    }
    
    private func fetchPokemonCardList(_ keyword: String) {
        searchDisposeBag = DisposeBag()
        
        repository.searchCard(searchKeyword: keyword, searchType: searchType, page: page)
            .subscribe(onNext: { [weak self] responseData in
                self?.cardList = responseData.data
                self?.pageSize = responseData.pageSize
                self?._rxViewState.onNext(.loaded)
            }, onError: { [weak self] error in
                if let error = error as? NetworkError {
                    self?._rxViewState.onNext(.error(error.description))
                } else {
                    self?._rxViewState.onNext(.error(error.localizedDescription))
                }
            })
            .disposed(by: searchDisposeBag)
    }
}
