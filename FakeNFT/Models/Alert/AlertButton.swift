//
//  AlertButton.swift
//  FakeNFT
//
//  Created by Aliaksandr Charnyshou on 14.12.2024.
//

import UIKit

// MARK: - AlertButton
struct AlertButton<T> {

    let text: String
    let style: UIAlertAction.Style
    let completion: (T) -> Void
}
