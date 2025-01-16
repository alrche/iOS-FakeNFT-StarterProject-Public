//
//  CustomAlertControllerForSort.swift
//  FakeNFT
//
//  Created by Doroteya Galbacheva on 17.12.2024.
//

import UIKit

final class CustomAlertControllerForSort: UIAlertController {
    private var customDimmingColor: UIColor?
    
    func setDimmingColor(_ color: UIColor) {
        customDimmingColor = color
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let color = customDimmingColor, let dimmingView = self.view.superview?.subviews.first {
            dimmingView.backgroundColor = color
        }
    }
}
