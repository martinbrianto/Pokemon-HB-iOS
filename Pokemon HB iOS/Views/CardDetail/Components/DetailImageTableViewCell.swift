//
//  DetailImageTableViewCell.swift
//  Pokemon HB iOS
//
//  Created by Martin Brianto on 09/11/23.
//

import UIKit
import Nuke

class DetailImageTableViewCell: UITableViewCell {

    // MARK: - UI Components
    
    private let cardImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    // MARK: - Variables
    
    static var reuseID = "DetailImageTableViewCell"
    
    // MARK: - Inits
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func configure(imageUrl: String) {
        if let imageUrl = URL(string: imageUrl) {
            let options = ImageLoadingOptions(transition: .fadeIn(duration: 0.5))
            Nuke.loadImage(with: imageUrl, options: options, into: cardImageView)
        }
    }
    
    // MARK: - Setup
    
    private func setupView() {
        contentView.addSubview(cardImageView)
        
        cardImageView.snp.makeConstraints { make in
            make.centerX.top.bottom.equalTo(contentView.safeAreaLayoutGuide)
            make.height.equalTo(400)
        }
    }
}
