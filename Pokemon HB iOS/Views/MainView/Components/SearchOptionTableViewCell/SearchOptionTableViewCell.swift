//
//  SearchOptionTableViewCell.swift
//  Pokemon HB iOS
//
//  Created by Martin Brianto on 08/11/23.
//

import UIKit

final class SearchOptionTableViewCell: UITableViewCell {
    
    // MARK: - UI Components
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let optionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "circle")
        return imageView
    }()
    
    // MARK: - Variables
    
    static let reuseID = "SearchOptionTableViewCell"
    
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
    
    func configure(isSelected: Bool, optionName: String) {
        titleLabel.text = optionName
        optionImageView.image = isSelected ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "circle")
    }
    
    // MARK: - Setup
    
    private func setupView() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(optionImageView)
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(contentView.safeAreaLayoutGuide)
            make.top.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(8)
        }
        
        optionImageView.snp.makeConstraints { make in
            make.size.equalTo(25)
            make.right.equalTo(contentView.safeAreaLayoutGuide)
            make.top.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(8)
            make.left.equalTo(titleLabel.snp.right)
        }
    }
}
