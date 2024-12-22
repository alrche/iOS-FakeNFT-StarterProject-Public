//
//  CatalogTableViewCell.swift
//  FakeNFT
//
//  Created by Doroteya Galbacheva on 17.12.2024.
//

import UIKit

final  class  CatalogTableViewCell: UITableViewCell {
    static let identifier = "CatalogTableViewCell"
    
    private lazy var topImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 12
        return image
    }()
    
    private lazy var nameAndCountLabel: UILabel = {
        let nameAndCountLabel = UILabel()
        nameAndCountLabel.translatesAutoresizingMaskIntoConstraints = false
        nameAndCountLabel.font = UIFont.Bold.small
        return nameAndCountLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        addSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubViews() {
        contentView.addSubview(topImage)
        contentView.addSubview(nameAndCountLabel)
        
        let heightCell = contentView.heightAnchor.constraint(equalToConstant: 179)
        heightCell.priority = .defaultHigh
        
        NSLayoutConstraint.activate([
            heightCell,
            topImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            topImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            topImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            topImage.heightAnchor.constraint(equalToConstant: 140),
            
            nameAndCountLabel.topAnchor.constraint(equalTo: topImage.bottomAnchor, constant: 4),
            nameAndCountLabel.leadingAnchor.constraint(equalTo: topImage.leadingAnchor),
            nameAndCountLabel.trailingAnchor.constraint(equalTo: topImage.trailingAnchor),
            nameAndCountLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -13),
        ])
    }
    
    func configCell(name: String, count: Int, image: UIImage) {
        topImage.image = image
        nameAndCountLabel.text = "\(name) (\(count))"
    }
}
