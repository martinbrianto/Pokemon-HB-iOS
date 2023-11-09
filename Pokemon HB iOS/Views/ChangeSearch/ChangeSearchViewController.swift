//
//  ChangeSearchViewController.swift
//  Pokemon HB iOS
//
//  Created by Martin Brianto on 08/11/23.
//

import UIKit
import RxSwift

final class ChangeSearchViewController: UIViewController {
    // MARK: - UI Components
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Change Search Parameter"
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchOptionTableViewCell.self, forCellReuseIdentifier: SearchOptionTableViewCell.reuseID)
        return tableView
    }()
    
    // MARK: - Variables
    
    private let _rxSelectedOption = PublishSubject<PokemonCardSearchType>()
    var rxSelectedOption: Observable<PokemonCardSearchType> { _rxSelectedOption }
    var disposeBag = DisposeBag()
    
    private var selectedSearchOption: PokemonCardSearchType
    
    // MARK: - Inits
    
    init(selectedSearchOption: PokemonCardSearchType) {
        self.selectedSearchOption = selectedSearchOption
        super.init(nibName: nil, bundle: nil)
        setupView()
        setupBinding()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Methods
    // MARK: - Setup
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        view.addSubview(titleLabel)
        view.addSubview(closeButton)
        
        titleLabel.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.right.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
    }
    
    private func setupBinding() {
        closeButton.rx.tap
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: { [weak self] in
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - UITableViewDataSource
extension ChangeSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PokemonCardSearchType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellData = PokemonCardSearchType.allCases[safe: indexPath.row], let cell = tableView.dequeueReusableCell(withIdentifier: SearchOptionTableViewCell.reuseID, for: indexPath) as? SearchOptionTableViewCell else { return UITableViewCell() }
        
        cell.configure(isSelected: selectedSearchOption == cellData, optionName: cellData.optionlabel)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ChangeSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let previousSelectedIndex = PokemonCardSearchType.allCases.firstIndex(of: selectedSearchOption) else { return }
        selectedSearchOption = PokemonCardSearchType.allCases[indexPath.row]
        tableView.reloadRows(at: [IndexPath(row: previousSelectedIndex, section: 0), indexPath], with: .none)
        _rxSelectedOption.onNext(selectedSearchOption)
    }
}
