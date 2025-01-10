//
//  DeleteNFTView.swift
//  FakeNFT
//
//  Created by Богдан Топорин on 10.01.2025.
//
import UIKit
import SnapKit
import Kingfisher

class ConfirmationPopupView: UIView {
    // MARK: - Subviews
    private let backgroundView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light) // Выбираем стиль блюра
        let view = UIVisualEffectView(effect: blurEffect)
        return view
    }()

    private let popupView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 20
        view.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        view.alpha = 0
        return view
    }()

    private let nftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        return imageView
    }()

    private let messageLabel: UILabel = {
        let label = UILabel()
        label.text = L.Cart.deleteQuestion
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = A.Colors.blackDynamic.color
        label.font = .Regular.small
        return label
    }()

    private let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(L.Cart.delete, for: .normal)
        button.titleLabel?.font = .Regular.large
        button.setTitleColor(A.Colors.red.color, for: .normal)
        button.backgroundColor = A.Colors.blackDynamic.color
        button.layer.cornerRadius = 12
        return button
    }()

    private let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(L.Cart.return, for: .normal)
        button.titleLabel?.font = .Regular.large
        button.setTitleColor(A.Colors.whiteDynamic.color, for: .normal)
        button.backgroundColor = A.Colors.blackDynamic.color
        button.layer.cornerRadius = 12
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        for subview in [deleteButton, cancelButton] {
            stackView.addArrangedSubview(subview)
        }
        stackView.skeletonCornerRadius = 12
        return stackView
    }()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        showWithAnimation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    func configCell(model: CartNFTModel) {
        setImage(url: model.image) { _ in }
    }

    private func setupView() {
        addSubview(backgroundView)
        addSubview(popupView)
        [nftImageView,messageLabel,stackView].forEach {
            popupView.addSubview($0)
        }
        backgroundView.snp.makeConstraints { $0.edges.equalToSuperview() }
        popupView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(262)
            $0.height.equalTo(220)
        }

        nftImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(108)
        }

        messageLabel.snp.makeConstraints {
            $0.top.equalTo(nftImageView.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }

        deleteButton.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.width.equalTo(127)
        }

        cancelButton.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.width.equalTo(127)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(messageLabel.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        deleteButton.addTarget(self, action: #selector(didTapDelete), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
    }

    // MARK: - Animation

    private func showWithAnimation() {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.popupView.transform = .identity
            self.popupView.alpha = 1
        })
    }

    private func hideWithAnimation(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.2, animations: {
            self.popupView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            self.popupView.alpha = 0
        }) { _ in
            completion?()
            self.removeFromSuperview()
        }
    }

    // MARK: - Actions
    var onDelete: (() -> Void)?
    var onCancel: (() -> Void)?

    @objc func didTapDelete() {
        onDelete?()
        hideWithAnimation()
    }

    @objc func didTapCancel() {
        onCancel?()
        hideWithAnimation()
    }
    
    // MARK: - Private methods
    
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
}
