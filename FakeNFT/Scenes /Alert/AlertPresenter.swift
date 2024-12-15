//
//  AlertPresenter.swift
//  FakeNFT
//
//  Created by Aliaksandr Charnyshou on 14.12.2024.
//

import UIKit

final class AlertPresenter {
    static func show(in controller: UIViewController, model: AlertModel) {
        let alert = UIAlertController(
            title: model.title,
            message: model.message,
            preferredStyle: model.preferredStyle
        )

        for button in model.buttons {
            let action = UIAlertAction(title: button.text, style: button.style) { _ in
                button.completion(())
            }
            alert.addAction(action)
        }
        if controller.presentedViewController == nil {
            controller.present(alert, animated: true, completion: nil)
        }
    }

    static func show(in controller: UIViewController, model: AlertWithTextFieldModel) {
        let alert = UIAlertController(
            title: model.title,
            message: model.message,
            preferredStyle: .alert
        )

        alert.addTextField { (textField) in
            textField.placeholder = model.textField.placeholder
        }

        let okAction = UIAlertAction(
            title: model.okButton.text,
            style: model.okButton.style
        ) { _ in
            model.okButton.completion(alert.textFields?.first?.text)
        }
        alert.addAction(okAction)

        let cancelAction = UIAlertAction(
            title: model.cancelButton.text,
            style: model.cancelButton.style
        ) { _ in
            model.cancelButton.completion(())
        }
        alert.addAction(cancelAction)

        if controller.presentedViewController == nil {
            controller.present(alert, animated: true, completion: nil)
        }
    }

}
