//
//  AlertButton.swift
//  FakeNFT
//
//  Created by Aliaksandr Charnyshou on 14.12.2024.
//

import UIKit

struct AlertButton<T> {

    let text: String
    let style: UIAlertAction.Style
    let completion: (T) -> Void
}
