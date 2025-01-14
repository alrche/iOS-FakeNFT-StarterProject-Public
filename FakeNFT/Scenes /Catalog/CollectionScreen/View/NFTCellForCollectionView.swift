//
//  NFTCellForCollectionView.swift
//  FakeNFT
//
//  Created by Doroteya Galbacheva on 17.12.2024.
//

import UIKit

final class NFTCellForCollectionView: UICollectionViewCell {
    static let reuseIdentifier = "NFTCollectionViewCell"
    private var isLike = false
    private var inCart = false
    
    private lazy var nftImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.kf.indicatorType = .activity
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Bold.small
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var ethLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Medium.small
        label.textColor = A.Colors.blackDynamic.color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var cartButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var ratingStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .fill
        view.distribution = .fillEqually
        view.spacing = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        constraintView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        isLike = false
        inCart = false
        nameLabel.text = ""
        nftImageView.image = nil
        updateRating(0)
        cartButton.setImage(nil, for: .normal)
        favoriteButton.setImage(nil, for: .normal)
        ethLabel.text = ""
    }
    
    func configure(nft: Nft) {
        isLike = true
        inCart  = true
        let fullName = nft.name
        let firstName = fullName.components(separatedBy: " ").first ?? fullName
        
        nameLabel.text = firstName
        
        let urlForImage = nft.images[0]
        nftImageView.kf.setImage(
            with: urlForImage,
            options: [
                .transition(.fade(1)),
                .cacheOriginalImage
            ]
        )
        let imageForLike = isLike ? A.Icons.favouriteActive.image : A.Icons.favouriteInactive.image
        favoriteButton.setImage(imageForLike, for: .normal)
        let imageForCart = inCart ? A.Icons.deleteNft.image.withTintColor(A.Colors.blackDynamic.color, renderingMode: .alwaysOriginal) : A.Icons.basket.image.withTintColor(A.Colors.blackDynamic.color, renderingMode: .alwaysOriginal)
        cartButton.setImage(imageForCart, for: .normal)
        ethLabel.text = "\(Int(nft.price)) \(L.Catalog.eth)"
        updateRating(nft.rating)
    }
    
    private func updateRating(_ rating: Int) {
        for (i, view) in ratingStackView.arrangedSubviews.enumerated() {
            if let star = view as? UIImageView {
                if i < rating {
                    star.image = A.Icons.activeStar.image
                } else {
                    star.image = A.Icons.inactiveStar.image
                }
            }
        }
    }
    
    private func constraintView() {
        for _ in 0..<5 {
            let star = UIImageView()
            star.image = A.Icons.inactiveStar.image
            star.contentMode = .scaleAspectFill
            star.translatesAutoresizingMaskIntoConstraints = false
            star.widthAnchor.constraint(equalToConstant: 12).isActive = true
            star.heightAnchor.constraint(equalToConstant: 12).isActive = true
            
            ratingStackView.addArrangedSubview(star)
        }
        
        [nftImageView,
         ratingStackView,
         nameLabel,
         ethLabel,
         favoriteButton,
         cartButton].forEach {
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            nftImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            nftImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nftImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nftImageView.widthAnchor.constraint(equalToConstant: 108),
            nftImageView.heightAnchor.constraint(equalTo: nftImageView.widthAnchor),
            
            ratingStackView.topAnchor.constraint(equalTo: nftImageView.bottomAnchor, constant: 8),
            ratingStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            ratingStackView.heightAnchor.constraint(equalToConstant: 12),
            ratingStackView.widthAnchor.constraint(equalToConstant: 68),
            
            nameLabel.topAnchor.constraint(equalTo: ratingStackView.bottomAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: cartButton.leadingAnchor),
            
            ethLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            ethLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            favoriteButton.topAnchor.constraint(equalTo: nftImageView.topAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: nftImageView.trailingAnchor),
            favoriteButton.widthAnchor.constraint(equalToConstant: 40),
            favoriteButton.heightAnchor.constraint(equalToConstant: 40),
            
            cartButton.topAnchor.constraint(equalTo: ratingStackView.bottomAnchor, constant: 4),
            cartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cartButton.widthAnchor.constraint(equalToConstant: 40),
            cartButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
