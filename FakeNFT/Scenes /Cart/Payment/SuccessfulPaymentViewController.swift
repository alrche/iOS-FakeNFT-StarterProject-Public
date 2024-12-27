//
//  SuccessfulPaymentViewController.swift
//  FakeNFT
//
//  Created by Богдан Топорин on 27.12.2024.
//

import UIKit

final class SuccessfulPaymentViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let successfulPaymentView = SuccsesfulPaymentView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        successfulPaymentView.delegate = self
        setupView()
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(successfulPaymentView)
        
        successfulPaymentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension SuccessfulPaymentViewController: SuccessfulPaymentButtonDelegate {
    func didTapPayButton() {
            guard let navigationController = self.navigationController else {
                print("NavigationController is not available.")
                return
            }
        if let tabBarController = self.tabBarController {
            if let catalogNavController = tabBarController.viewControllers?.first(where: { $0 is UINavigationController }) as? UINavigationController {
                catalogNavController.popToRootViewController(animated: true)
                tabBarController.selectedIndex = 1
            }
        }
        navigationController.navigationBar.isHidden = false
        navigationController.popToRootViewController(animated: true)
    }
}
