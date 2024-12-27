//
//  PaymentBottomTableViewCell.swift
//  FakeNFT
//
//  Created by Богдан Топорин on 27.12.2024.
//

import Foundation
import UIKit
import SkeletonView

protocol PaymentTableViewCellDelegate: AnyObject {
    func didTapPayButton()
}

final class PaymentBottomTableViewCell: UITableViewCell,ReuseIdentifying {
    
    weak var delegate: PaymentTableViewCellDelegate?
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
            static let Height: CGFloat = 60
            static let Width: CGFloat = 343
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
        button.addTarget(self, action: #selector(handlePayButtonTapped), for: .touchUpInside)
        return button
    }()
    private lazy var payNftStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        for subview in [termsLabel] {
            stackView.addArrangedSubview(subview)
        }
        stackView.skeletonCornerRadius = 12
        return stackView
    }()
    
    private let termsLabel: UILabel = {
        let label = UILabel()
        label.font = .Regular.small
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.isUserInteractionEnabled = true
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
    
    func configCell() {
        setupTermsLabel()
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
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(44)
            make.width.equalTo(316)
        }
        
        payButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalTo(payNftStackView.snp.bottom).offset(16)
            make.height.equalTo(Constants.PayButton.Height)
            make.width.equalTo(Constants.PayButton.Width)
        }
    }
    
}

extension PaymentBottomTableViewCell {
    @objc private func handleButtonPressDown() {
        UIView.animate(withDuration: 0.2) {
            self.payButton.alpha = 0.6
            self.payButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }
    
    @objc private func handleButtonPressUp() {
        UIView.animate(withDuration: 0.2) {
            self.payButton.alpha = 1.0
            self.payButton.transform = .identity
        }
    }
    
    @objc private func handlePayButtonTapped() {
            delegate?.didTapPayButton()
        }
}

extension PaymentBottomTableViewCell {
    private func setupTermsLabel() {
        let fullText = L.Cart.userAgreementStart + " " + L.Cart.userAgreementEnd
        let linkText = L.Cart.userAgreementEnd
        let attributedString = NSMutableAttributedString(string: fullText)
        if let linkRange = fullText.range(of: linkText) {
            let nsRange = NSRange(linkRange, in: fullText)
            attributedString.addAttribute(.foregroundColor, value: A.Colors.blue.color, range: nsRange)
        } else {
            print("Link text not found in fullText.")
        }
        termsLabel.attributedText = attributedString
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleLinkTap))
        tapGesture.cancelsTouchesInView = false
        termsLabel.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleLinkTap() {
        if let url = URL(string: "https://yandex.ru/legal/practicum_termsofuse/") {
            UIApplication.shared.open(url)
        }
    }
}
