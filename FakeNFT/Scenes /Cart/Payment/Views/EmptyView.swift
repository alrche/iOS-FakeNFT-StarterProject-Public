//
//  EmptyView.swift
//  FakeNFT
//
//  Created by Богдан Топорин on 27.12.2024.
//

import UIKit
import SnapKit

final class EmptyView: UIView {

    // MARK: - Private Properties
    private let label: UILabel = {
        let label = UILabel()
        label.text = L.Cart.cartEmpty
        label.textColor = A.Colors.blackDynamic.color
        label.textAlignment = .center
        label.font = .Bold.small
        return label
    }()

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    // MARK: - Private Methods
    private func setupUI() {
        backgroundColor = .white
        addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
