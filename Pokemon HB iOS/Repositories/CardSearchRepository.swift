//
//  CardSearchRepository.swift
//  Pokemon HB iOS
//
//  Created by Martin Brianto on 08/11/23.
//

import Foundation
import RxSwift

protocol CardSearchRepository {
    func searchCard(searchKeyword: String,searchType: PokemonCardSearchType, page: Int) -> Observable<PokemonCardList>
}

final class CardSearchRepositoryImpl: CardSearchRepository {
    private let apiClient: ApiClient
    
    init(apiClient: ApiClient = ApiClientImpl()) {
        self.apiClient = apiClient
    }
    
    func searchCard(searchKeyword: String, searchType: PokemonCardSearchType, page: Int) -> Observable<PokemonCardList> {
        
        var params: [String:Any] = [
            "page":page,
            "pageSize":8
        ]
        
        if !searchKeyword.isEmpty {
            params["q"] = "\(searchType.searchParameter):\(searchKeyword)"
        }
        
        return apiClient.getString("/cards", params: params)
            .asObservable()
            .flatMap { jsonString -> Observable<PokemonCardList> in
                
                jsonString.toRxCodable()
            }
    }
}
