//
//  MainViewController.swift
//  Pokemon HB iOS
//
//  Created by Martin Brianto on 08/11/23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class MainViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let activityView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.isHidden = true
        return view
    }()
    
    private let emptyView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "empty-search")
        view.isHidden = true
        return view
    }()
    
    private lazy var searchBar: UISearchBar = {
        let view = UISearchBar(frame: .zero)
        view.searchTextField.placeholder = "Search by pokemon name"
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CardTableViewCell.self, forCellReuseIdentifier: CardTableViewCell.reuseID)
        return tableView
    }()
    
    private let changeSearchTypeButton = UIBarButtonItem(systemItem: .search)
    
    // MARK: - Variables
    
    private let viewModel: MainViewModel
    private let disposeBag = DisposeBag()
    
    private let bottomInset: CGFloat = UIApplication.shared.windows.first?.safeAreaInsets.bottom != 0 ? 10 : 20
    private var bottomConstraint: Constraint?
    
    // MARK: - Inits
    
    init(viewModel: MainViewModel = MainViewModelImpl()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupView()
        setupBinding()
        setupKeyboardNotification()
        viewModel.loadInitialData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Private Methods
    
    private func presentChangeSearchViewController() {
        let vc = ChangeSearchViewController(selectedSearchOption: viewModel.searchType)
        
        vc.rxSelectedOption
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: { [weak self] option in
                self?.viewModel.changeSearchType(to: option)
                vc.dismiss(animated: true)
            })
            .disposed(by: vc.disposeBag)
        
        present(vc, animated: true)
    }
    
    private func navigateToDetailCard(for detail: PokemonCard) {
        let vc = CardDetailViewController(pokemonCard: detail)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func presentErrorAlert(title: String, description: String) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Setup
    
    private func setupKeyboardNotification() {
        NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
            .take(until: rx.viewWillDisappear())
            .subscribe(onNext: { [weak self] notification in
                guard let self else { return }
                
                UIView.animateAlongside(keyboardNotification: notification) { keyboardEndFrame in
                    self.bottomConstraint?.update(offset: -keyboardEndFrame.height + 20)
                    self.view.layoutIfNeeded()
                }
            })
            .disposed(by: disposeBag)
        
        NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
            .take(until: rx.viewWillDisappear())
            .subscribe(onNext: { [weak self] notification in
                guard let self else { return }
                
                UIView.animateAlongside(keyboardNotification: notification) { _ in
                    self.bottomConstraint?.update(offset: -self.bottomInset)
                    self.view.layoutIfNeeded()
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func setupView() {
        view.enableTapToDismissKeyboard()
        
        navigationItem.title = "Pokemon TCG Search"
        navigationItem.rightBarButtonItem = changeSearchTypeButton
        view.backgroundColor = .systemBackground
        
        view.addSubview(searchBar)
        view.addSubview(tableView)
        view.addSubview(emptyView)
        view.addSubview(activityView)
        
        searchBar.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
        }
        
        activityView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(8)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.left.bottom.right.equalTo(view.safeAreaLayoutGuide)
            self.bottomConstraint = make.bottom.equalTo(view.safeAreaLayoutGuide).constraint
        }
        
        emptyView.snp.makeConstraints { make in
            make.size.equalTo(300)
            make.centerY.centerX.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupBinding() {
        viewModel.rxViewState
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: { [weak self] state in
                guard let self else { return }
                switch state {
                case .loading:
                    self.activityView.isHidden = false
                    self.activityView.startAnimating()
                    self.tableView.isHidden = true
                case .loaded:
                    self.activityView.isHidden = true
                    self.activityView.stopAnimating()
                    self.tableView.isHidden = self.viewModel.cardList.isEmpty
                    self.emptyView.isHidden = !self.viewModel.cardList.isEmpty
                    self.tableView.reloadData()
                case let .error(errorDescription):
                    self.activityView.isHidden = true
                    self.activityView.stopAnimating()
                    self.presentErrorAlert(title: "Error Occurred", description: errorDescription)
                }
            })
            .disposed(by: disposeBag)
        
        Observable.merge(searchBar.rx.searchButtonClicked.asObservable(),
                         searchBar.rx.cancelButtonClicked.asObservable())
        .asDriver(onErrorDriveWith: .empty())
        .drive(onNext: { [weak self] in
            self?.viewModel.searchPokemonCard(self?.searchBar.text ?? "")
        })
        .disposed(by: disposeBag)
        
        changeSearchTypeButton.rx.tap
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: { [weak self] in
                self?.presentChangeSearchViewController()
            })
            .disposed(by: disposeBag)
        
        viewModel.rxSearchType
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: { [weak self] searchType in
                self?.searchBar.placeholder = searchType.searchBarPlaceholder
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cardList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellData = viewModel.cardList[safe: indexPath.row], let cell = tableView.dequeueReusableCell(withIdentifier: CardTableViewCell.reuseID, for: indexPath) as? CardTableViewCell else { return UITableViewCell() }
        
        cell.configure(name: cellData.name, imageUrl: cellData.images.small, setImageUrl: cellData.set.images.logo)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Trigger infinite scrolling
        if indexPath.row >= viewModel.cardList.endIndex - 1 {
            viewModel.loadMorePokemonCard()
        }
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detail = viewModel.cardList[safe:indexPath.row] else { return }
        navigateToDetailCard(for: detail)
    }
}
