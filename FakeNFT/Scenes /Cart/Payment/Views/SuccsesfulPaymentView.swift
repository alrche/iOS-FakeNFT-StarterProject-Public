//
//  SuccsesfulPaymentView.swift
//  FakeNFT
//
//  Created by Богдан Топорин on 27.12.2024.
//

import Foundation
import UIKit
import SnapKit

protocol SuccessfulPaymentButtonDelegate: AnyObject {
    func didTapPayButton()
}

final class SuccsesfulPaymentView: UIView {
    
    weak var delegate: SuccessfulPaymentButtonDelegate?
    //MARK: - Private Properties
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(asset: A.Images.Cart.successPay)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = L.Cart.successPay
        label.font = .Bold.medium
        label.textColor = A.Colors.blackDynamic.color
        return label
    }()
    
    private let actionButton: UIButton = {
        let button = UIButton()
        button.setTitle(L.Cart.backCataloge, for: .normal)
        button.titleLabel?.font = .Bold.small
        button.backgroundColor = A.Colors.blackDynamic.color
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleButtonPressDown), for: .touchDown)
        button.addTarget(self, action: #selector(handleButtonPressUp), for: [.touchUpInside, .touchCancel, .touchDragExit])
        button.addTarget(self, action: #selector(handlePayButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        backgroundColor = .white // Настройте цвет под ваши требования
        
        addSubview(imageView)
        addSubview(textLabel)
        addSubview(actionButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-60)
            make.width.height.lessThanOrEqualTo(278)
        }
        
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(36)
            make.trailing.equalToSuperview().offset(-36)
        }
        
        actionButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-16)
        }
    }
}


extension SuccsesfulPaymentView {
    @objc private func handleButtonPressDown() {
        UIView.animate(withDuration: 0.2) {
            self.actionButton.alpha = 0.6
            self.actionButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }
    
    @objc private func handleButtonPressUp() {
        UIView.animate(withDuration: 0.2) {
            self.actionButton.alpha = 1.0
            self.actionButton.transform = .identity
        }
    }
    
    @objc private func handlePayButtonTapped() {
        delegate?.didTapPayButton()
    }
}
