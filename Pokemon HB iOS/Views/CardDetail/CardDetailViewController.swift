//
//  CardDetailViewController.swift
//  Pokemon HB iOS
//
//  Created by Martin Brianto on 09/11/23.
//

import UIKit
import RxSwift
import SafariServices

final class CardDetailViewController: UIViewController {
    
    enum CellType: Int, CaseIterable {
        case imageCell
        case priceCell
    }

    // MARK: - UI Components
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.dataSource = self
        tableView.register(DetailImageTableViewCell.self, forCellReuseIdentifier: DetailImageTableViewCell.reuseID)
        tableView.register(DetailPriceTableViewCell.self, forCellReuseIdentifier: DetailPriceTableViewCell.reuseID)
        return tableView
    }()
    
    private let buyButton: UIButton = {
        let button = UIButton()
        button.configuration = .filled()
        button.setTitle("Browse Card Market", for: .normal)
        return button
    }()
    
    // MARK: - Variables
    
    private let pokemonCard: PokemonCard
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Inits
    
    init(pokemonCard: PokemonCard) {
        self.pokemonCard = pokemonCard
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
    
    // MARK: - Setup
    
    private func setupView() {
        navigationItem.title = pokemonCard.name
        
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
        let buttonContainer = UIView()
        buttonContainer.backgroundColor = .quaternarySystemFill
        buttonContainer.addSubview(buyButton)
        
        view.addSubview(buttonContainer)
        
        buttonContainer.snp.makeConstraints { make in
            make.left.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
        
        buyButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.left.top.right.equalToSuperview().inset(8)
            make.bottom.equalTo(buttonContainer.safeAreaLayoutGuide).inset(8)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(buttonContainer.snp.top).offset(16)
        }
    }
    
    private func setupBinding() {
        buyButton.rx.tap
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: { [weak self] in
                self?.openWebViewWithSafari(urlString: self?.pokemonCard.cardmarket?.url ?? "")
            })
            .disposed(by: disposeBag)
        
    }
    
    // MARK: - Private Methods
    func openWebViewWithSafari(urlString: String) {
            // Check if the URL is valid
            if let url = URL(string: urlString) {
                // Initialize a Safari View Controller with the provided URL
                let safariViewController = SFSafariViewController(url: url)
                
                // Present the Safari View Controller modally
                present(safariViewController, animated: true, completion: nil)
            } else {
                // Handle invalid URL here
                print("Invalid URL: \(urlString)")
            }
        }
}

// MARK: - UITableViewDataSource
extension CardDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch CellType(rawValue: indexPath.row) {
        case .imageCell:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailImageTableViewCell.reuseID) as? DetailImageTableViewCell else { return UITableViewCell() }
            cell.configure(imageUrl: pokemonCard.images.large)
            return cell
        case .priceCell:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailPriceTableViewCell.reuseID) as? DetailPriceTableViewCell else { return UITableViewCell() }
            let cardPriceData = pokemonCard.cardmarket?.prices
            cell.configure(
                lowestPrice: cardPriceData?.lowPrice ?? 0,
                priceTrend: cardPriceData?.trendPrice ?? 0,
                avg30Price: cardPriceData?.avg30 ?? 0,
                avg7Price: cardPriceData?.avg7 ?? 0,
                avg1Price: cardPriceData?.avg1 ?? 0
            )
            return cell
        default: return UITableViewCell()
        }
        
    }
}
