//
//  CartPayTableViewCell.swift
//  FakeNFT
//
//  Created by Богдан Топорин on 19.12.2024.
//

import Foundation
import UIKit
import SkeletonView

final class CartPayTableViewCell: UITableViewCell,ReuseIdentifying {
    // MARK: - Private properties

    private enum Constants {
        static let skeletonText = "             "
        enum PayStackView {
            static let spacing: CGFloat = 2
            static let leadingInset: CGFloat = 20
            static let height: CGFloat = 42
        }
        enum ViewWithContent {
            static let inset: CGFloat = 16
        }
        enum PayButton {
            static let Height: CGFloat = 44
            static let Width: CGFloat = 240
        }
    }

    private let viewWithContent: UIView = {
        let view = UIView()
        view.backgroundColor = A.Colors.lightGrayDynamic.color
        return view
    }()
  
    private let payButton: UIButton = {
        let button = UIButton()
        button.setTitle(L.Cart.pay, for: .normal)
        button.titleLabel?.font = .Bold.small
        button.backgroundColor = A.Colors.blackDynamic.color
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleButtonPressDown), for: .touchDown)
        button.addTarget(self, action: #selector(handleButtonPressUp), for: [.touchUpInside, .touchCancel, .touchDragExit])
        return button
    }()
    private lazy var payNftStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = Constants.PayStackView.spacing
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        for subview in [nftCountLabel, totalPriceLabel] {
            stackView.addArrangedSubview(subview)
        }
        stackView.skeletonCornerRadius = 12
        return stackView
    }()
    
    private let nftCountLabel: UILabel = {
        let label = UILabel()
        label.font = .Regular.small
        label.textColor = A.Colors.blackDynamic.color
        label.text = Constants.skeletonText
        label.skeletonCornerRadius = 12
        return label
    }()
    private let totalPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .Bold.small
        label.textColor = A.Colors.green.color
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

  
    // MARK: - Public methods

    func configCell(model: [CartNFTModel]) {
        nftCountLabel.text = "\(model.count) NFT"
        let totalPrice = model
            .reduce(0.0) { $0 + $1.price }
        totalPriceLabel.text = "\(totalPrice) ETH"
    }

    private func setupUI() {
        contentView.addSubview(viewWithContent)
        [payNftStackView, payButton].forEach {
            viewWithContent.addSubview($0)
        }
        
        [viewWithContent, payNftStackView, payButton
        ].forEach {
            $0.isSkeletonable = true
        }
        self.isSkeletonable = true
        contentView.isSkeletonable = true
        contentView.backgroundColor = A.Colors.lightGrayDynamic.color
    }

    private func setupLayout() {
        viewWithContent.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Constants.ViewWithContent.inset)
        }

        payNftStackView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.height.equalTo(44)
        }

        payButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.leading.equalTo(payNftStackView.snp.trailing).offset(24)
            make.centerY.equalToSuperview()
            make.height.equalTo(Constants.PayButton.Height)
            make.width.equalTo(Constants.PayButton.Width)
        }
    }

}

extension CartPayTableViewCell {
    @objc private func handleButtonPressDown() {
        UIView.animate(withDuration: 0.2) {
            self.alpha = 0.6
            self.payButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }
    
    @objc private func handleButtonPressUp() {
        UIView.animate(withDuration: 0.2) {
            self.payButton.alpha = 1.0
            self.payButton.transform = .identity
        }
    }
}
