//
//  CartNavigationViewController.swift
//  FakeNFT
//
//  Created by Богдан Топорин on 19.12.2024.
//

import Foundation
import UIKit

final class CartNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
}

// MARK: - UIGestureRecognizerDelegate

extension CartNavigationViewController: UIGestureRecognizerDelegate {

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }

}
