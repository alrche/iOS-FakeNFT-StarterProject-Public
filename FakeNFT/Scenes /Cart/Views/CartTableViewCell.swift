//
//  CartTableViewCell.swift
//  FakeNFT
//
//  Created by Богдан Топорин on 19.12.2024.
//

import UIKit
import SkeletonView
import Kingfisher

final class CartTableViewCell: UITableViewCell, ReuseIdentifying {
    // MARK: - Private properties
    
    private enum Constants {
        static let skeletonText = "             "
        enum ImageView {
            static let cornerRadius: CGFloat = 12
            static let widthAndHeight: CGFloat = 108
            static let maxRetryCount: Int = 2
            static let retryInterval: DelayRetryStrategy.Interval = .seconds(3)
        }
        enum InfoStackView {
            static let spacing: CGFloat = 4
            static let leadingInset: CGFloat = 20
            static let height: CGFloat = 42
        }
        enum PriceStackView {
            static let spacing: CGFloat = 2
            static let width: CGFloat = 100
        }
        enum ViewWithContent {
            static let inset: CGFloat = 16
        }
        enum DeleteButton {
            static let widthAndHeight: CGFloat = 40
        }
    }
    
    private let viewWithContent: UIView = {
        let view = UIView()
        view.backgroundColor = A.Colors.whiteDynamic.color
        return view
    }()
    
    private let nftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = Constants.ImageView.cornerRadius
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(A.Icons.deleteNft.image, for: .normal)
        button.tintColor = A.Colors.blackDynamic.color
        button.backgroundColor = .clear
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleButtonPressDown), for: .touchDown)
        button.addTarget(self, action: #selector(handleButtonPressUp), for: [.touchUpInside, .touchCancel, .touchDragExit])
        return button
    }()
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = Constants.InfoStackView.spacing
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        for subview in [nftNameLabel, ratingStackView, priceStackView] {
            stackView.addArrangedSubview(subview)
        }
        stackView.skeletonCornerRadius = 12
        return stackView
    }()
    
    private lazy var priceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = Constants.PriceStackView.spacing
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        for subview in [priceTitleLabel, priceLabel] {
            stackView.addArrangedSubview(subview)
        }
        stackView.skeletonCornerRadius = 12
        return stackView
    }()
    
    private let ratingStackView = RatingStackView()
    
    
    private let nftNameLabel: UILabel = {
        let label = UILabel()
        label.font = .Bold.small
        label.textColor = A.Colors.blackDynamic.color
        label.text = Constants.skeletonText
        label.skeletonCornerRadius = 12
        return label
    }()
    
    
    private let priceTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .Regular.small
        label.textColor = A.Colors.blackDynamic.color
        label.text = L.Cart.price
        label.skeletonCornerRadius = 12
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .Bold.small
        label.textColor = A.Colors.blackDynamic.color
        label.text = Constants.skeletonText
        label.skeletonCornerRadius = 12
        return label
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overridden methods
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nftImageView.kf.cancelDownloadTask()
    }
    
    // MARK: - Public methods
    
    func configCell(model: CartNFTModel) {
        setImage(url: model.image) { _ in }
        nftNameLabel.text = model.name
        priceLabel.text = "\(model.price) ETH"
        ratingStackView.setRating(rating: model.rating)
    }
    
    // MARK: - Private methods
    
    private func setImage(
        url: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        guard let url = URL(string: url) else { return }
        
        let placeholder: UIImage = A.Images.Profile.stub.image
        let retry = DelayRetryStrategy(
            maxRetryCount: Constants.ImageView.maxRetryCount,
            retryInterval: Constants.ImageView.retryInterval
        )
        nftImageView.kf.indicatorType = .activity
        nftImageView.kf.setImage(
            with: url,
            placeholder: placeholder,
            options: [.retryStrategy(retry)]
        ) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                self.nftImageView.image = A.Images.Profile.stub.image
                completion(.failure(error))
            }
        }
    }
    
    private func setupUI() {
        backgroundColor = A.Colors.whiteDynamic.color
        contentView.addSubview(viewWithContent)
        
        [nftImageView, infoStackView, priceStackView,deleteButton].forEach {
            viewWithContent.addSubview($0)
        }
        
        [viewWithContent, nftImageView, infoStackView, priceStackView,
         deleteButton
        ].forEach {
            $0.isSkeletonable = true
        }
       
        
        self.isSkeletonable = true
        contentView.isSkeletonable = true
    }
    
    private func setupLayout() {
        viewWithContent.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Constants.ViewWithContent.inset)
        }
        
        nftImageView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.width.height.equalTo(Constants.ImageView.widthAndHeight)
        }
        
        infoStackView.snp.makeConstraints { make in
            make.leading.equalTo(nftImageView.snp.trailing).offset(Constants.InfoStackView.leadingInset)
            make.top.equalTo(nftImageView.snp.top).offset(8)
            make.height.equalTo(Constants.InfoStackView.height)
        }
        
        priceStackView.snp.makeConstraints { make in
            make.leading.equalTo(infoStackView.snp.leading)
            make.top.equalTo(infoStackView.snp.bottom).offset(12)
            make.bottom.equalTo(nftImageView.snp.bottom).offset(-8)
            make.height.equalTo(38)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(Constants.DeleteButton.widthAndHeight)
        }
    }
    
}

extension CartTableViewCell {
    @objc private func handleButtonPressDown() {
        UIView.animate(withDuration: 0.2) {
            self.deleteButton.alpha = 0.6
            self.deleteButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }
    
    @objc private func handleButtonPressUp() {
        UIView.animate(withDuration: 0.2) {
            self.deleteButton.alpha = 1.0
            self.deleteButton.transform = .identity
        }
    }
}
