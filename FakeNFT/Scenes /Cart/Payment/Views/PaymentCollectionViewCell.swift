//
//  PaymentCollectionViewCell.swift
//  FakeNFT
//
//  Created by Богдан Топорин on 27.12.2024.
//

import Foundation
import SnapKit
import SkeletonView
import Kingfisher
    
final class PaymentCollectionViewCell: UICollectionViewCell, ReuseIdentifying {
    //MARK: - Private Properties
    private let PaymentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let PaymentTitle: UILabel = {
        let label = UILabel()
        label.font = .Regular.small
        label.textColor = A.Colors.blackDynamic.color
        return label
    }()
    
    private let PaymentSubTitle: UILabel = {
        let label = UILabel()
        label.font = .Regular.small
        label.textColor = A.Colors.green.color
        return label
    }()
    
    private lazy var PaymentTitlesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fillProportionally
        for subview in [PaymentTitle, PaymentSubTitle] {
            stackView.addArrangedSubview(subview)
        }
        stackView.skeletonCornerRadius = 12
        return stackView
    }()
    
    private let viewWithContent: UIView = {
        let view = UIView()
        view.backgroundColor = A.Colors.lightGrayDynamic.color
        return view
    }()
    
    private lazy var PaymentImageViewContainer: UIView = {
        let container = UIView()
        container.backgroundColor = A.Colors.blackDynamic.color
        container.layer.cornerRadius = 6
        container.layer.masksToBounds = true
        container.addSubview(PaymentImageView)
        return container
    }()

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Override methods
    override func prepareForReuse() {
        super.prepareForReuse()
        PaymentImageView.kf.cancelDownloadTask()
    }
    
    //MARK: - Public Methods
    func configCell(with model: CurrencyModel) {
        setImage(url: model.image) { _ in }
        PaymentTitle.text = model.title
        PaymentSubTitle.text = model.name
    }
    
    func setSelected(_ isSelected: Bool) {
        contentView.layer.borderWidth = isSelected ? 1 : 0
        contentView.layer.borderColor = isSelected ? A.Colors.blackDynamic.color.cgColor : nil
    }

    
    //MARK: - Private methods
    private func setImage(
        url: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        guard let url = URL(string: url) else { return }
        
        let placeholder: UIImage = A.Images.Profile.stub.image
        let retry = DelayRetryStrategy(
            maxRetryCount: 2,
            retryInterval: .seconds(3)
        )
        PaymentImageView.kf.indicatorType = .activity
        PaymentImageView.kf.setImage(
            with: url,
            placeholder: placeholder,
            options: [.retryStrategy(retry)]
        ) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                self.PaymentImageView.image = A.Images.Profile.stub.image
                completion(.failure(error))
            }
        }
    }
    
    private func setupUI() {
        [PaymentImageViewContainer,PaymentImageView,PaymentTitle,PaymentSubTitle,PaymentTitlesStackView].forEach {
            $0.isSkeletonable = true
        }
        self.isSkeletonable = true
        contentView.isSkeletonable = true
        
        [PaymentTitlesStackView, PaymentImageViewContainer].forEach {
            contentView.addSubview($0)
        }
        
        contentView.backgroundColor = A.Colors.lightGrayDynamic.color
        contentView.layer.cornerRadius = 12
        
        
        
        PaymentImageView.snp.makeConstraints { make in
                make.edges.equalTo(PaymentImageViewContainer)
            }
        
        
        PaymentImageViewContainer.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(36)
        }

        PaymentTitlesStackView.snp.makeConstraints { make in
            make.leading.equalTo(PaymentImageViewContainer.snp.trailing).offset(4)
            make.centerY.equalToSuperview()
        }
    }
}
