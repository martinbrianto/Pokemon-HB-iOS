//
//  CardTableViewCell.swift
//  Pokemon HB iOS
//
//  Created by Martin Brianto on 08/11/23.
//

import UIKit
import SnapKit
import Nuke

class CardTableViewCell: UITableViewCell {
    // MARK: - UI Components
    
    private let image: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let setImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        //label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    // MARK: - Variables
    
    static let reuseID = "CardTableViewCell"
    
    // MARK: - Inits
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        image.image = nil
        nameLabel.text = nil
    }
    
    // MARK: - Methods
    
    func configure(name: String, imageUrl: String, setImageUrl: String) {
        nameLabel.text = name
        
        if let imageUrl = URL(string: imageUrl), let setImageUrl = URL(string: setImageUrl) {
            let options = ImageLoadingOptions(transition: .fadeIn(duration: 0.5))
            Nuke.loadImage(with: imageUrl, options: options, into: image)
            Nuke.loadImage(with: setImageUrl, options: options, into: setImage)
        }
    }
    
    // MARK: - Setup
    
    private func setupView() {
        selectionStyle = .none
        
        contentView.addSubview(image)
        contentView.addSubview(nameLabel)
        contentView.addSubview(setImage)
        
        image.snp.makeConstraints { make in
            make.size.equalTo(75)
            make.top.left.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(8)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(image.snp.right).offset(8)
            make.top.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(8)
        }
        
        setImage.snp.makeConstraints { make in
            make.top.bottom.right.equalTo(contentView.safeAreaLayoutGuide).inset(8)
            make.width.equalTo(50)
            make.left.equalTo(nameLabel.snp.right).offset(8)
        }
    }
}
