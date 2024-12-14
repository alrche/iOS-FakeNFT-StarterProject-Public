//
//  EditProfileLabel.swift
//  FakeNFT
//
//  Created by Aliaksandr Charnyshou on 14.12.2024.
//

import UIKit

// MARK: - EditProfileLabel
final class EditProfileLabel: UILabel {

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        font = .Bold.medium
        textColor = A.Colors.blackDynamic.color
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
