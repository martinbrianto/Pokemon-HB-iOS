//
//  DetailPriceTableViewCell.swift
//  Pokemon HB iOS
//
//  Created by Martin Brianto on 09/11/23.
//

import UIKit

class DetailPriceTableViewCell: UITableViewCell {

    // MARK: - UI Components
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Card Market"
        return label
    }()
    
    private let lowPriceTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Lowest Price"
        return label
    }()
    
    private let priceTrendTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Price Trend"
        return label
    }()
    
    private let avg30Title: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "30-days average price"
        return label
    }()
    
    private let avg7Title: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "7-days average price"
        return label
    }()
    
    private let avg1Title: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "1-days average price"
        return label
    }()
    
    private let lowPriceValue: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "-"
        return label
    }()
    
    private let priceTrendValue: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "-"
        return label
    }()
    
    private let avg30Value: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "-"
        return label
    }()
    
    private let avg7Value: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "-"
        return label
    }()
    
    private let avg1Value: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "-"
        return label
    }()
    
    // MARK: - Variables
    
    static let reuseID = "DetailPriceTableViewCell"
    
    // MARK: - Inits
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    // MARK: - Methods
    
    func configure(lowestPrice: Double, priceTrend: Double, avg30Price: Double, avg7Price: Double, avg1Price: Double) {
        lowPriceValue.text = lowestPrice.toCurrencyString()
        priceTrendValue.text = priceTrend.toCurrencyString()
        avg30Value.text = avg30Price.toCurrencyString()
        avg7Value.text = avg7Price.toCurrencyString()
        avg1Value.text = avg1Price.toCurrencyString()
    }
    
    // MARK: - Setup
    
    private func setupView() {
        let separatorView = UIView()
        separatorView.backgroundColor = .secondarySystemBackground
        
        let separatorView2 = UIView()
        separatorView2.backgroundColor = .secondarySystemBackground
        
        contentView.addSubview(separatorView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(lowPriceTitle)
        contentView.addSubview(priceTrendTitle)
        contentView.addSubview(avg30Title)
        contentView.addSubview(avg7Title)
        contentView.addSubview(avg1Title)
        
        contentView.addSubview(lowPriceValue)
        contentView.addSubview(priceTrendValue)
        contentView.addSubview(avg30Value)
        contentView.addSubview(avg7Value)
        contentView.addSubview(avg1Value)
        contentView.addSubview(separatorView2)
        
        separatorView.snp.makeConstraints { make in
            make.height.equalTo(8)
            make.top.equalToSuperview().inset(8)
            make.left.right.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom).offset(8)
            make.left.right.equalTo(contentView.safeAreaLayoutGuide).inset(8)
        }
        
        lowPriceTitle.snp.makeConstraints { make in
            make.left.equalTo(contentView.safeAreaLayoutGuide).inset(8)
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
        }
        
        lowPriceValue.snp.makeConstraints { make in
            make.right.equalTo(contentView.safeAreaLayoutGuide).inset(8)
            make.top.equalTo(lowPriceTitle.snp.top)
        }
        
        priceTrendTitle.snp.makeConstraints { make in
            make.left.equalTo(contentView.safeAreaLayoutGuide).inset(8)
            make.top.equalTo(lowPriceTitle.snp.bottom).offset(8)
        }
        
        priceTrendValue.snp.makeConstraints { make in
            make.right.equalTo(contentView.safeAreaLayoutGuide).inset(8)
            make.top.equalTo(priceTrendTitle.snp.top)
        }
        
        avg30Title.snp.makeConstraints { make in
            make.left.equalTo(contentView.safeAreaLayoutGuide).inset(8)
            make.top.equalTo(priceTrendTitle.snp.bottom).offset(8)
        }
        
        avg30Value.snp.makeConstraints { make in
            make.right.equalTo(contentView.safeAreaLayoutGuide).inset(8)
            make.top.equalTo(avg30Title.snp.top)
        }
        
        avg7Title.snp.makeConstraints { make in
            make.left.equalTo(contentView.safeAreaLayoutGuide).inset(8)
            make.top.equalTo(avg30Title.snp.bottom).offset(8)
        }
        
        avg7Value.snp.makeConstraints { make in
            make.right.equalTo(contentView.safeAreaLayoutGuide).inset(8)
            make.top.equalTo(avg7Title.snp.top)
        }
        
        avg1Title.snp.makeConstraints { make in
            make.left.equalTo(contentView.safeAreaLayoutGuide).inset(8)
            make.top.equalTo(avg7Title.snp.bottom).offset(8)
        }
        
        avg1Value.snp.makeConstraints { make in
            make.right.equalTo(contentView.safeAreaLayoutGuide).inset(8)
            make.top.equalTo(avg1Title.snp.top)
        }
        
        separatorView2.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(8)
            make.left.right.equalToSuperview()
            make.height.equalTo(8)
            make.top.equalTo(avg1Title.snp.bottom).offset(8)
        }
    }
}
