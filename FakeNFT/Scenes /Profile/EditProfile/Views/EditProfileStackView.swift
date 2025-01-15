//
//  EditProfileStackView.swift
//  FakeNFT
//
//  Created by Aliaksandr Charnyshou on 14.12.2024.
//

import UIKit

// MARK: - EditProfileStackView

final class EditProfileStackView: UIStackView {

    // MARK: - Initializers
    
    init(spacing: CGFloat, arrangedSubviews: [UIView]) {
        super.init(frame: .zero)
        self.spacing = spacing
        axis = .vertical
        distribution = .fillProportionally
        for subview in arrangedSubviews {
            addArrangedSubview(subview)
        }
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
