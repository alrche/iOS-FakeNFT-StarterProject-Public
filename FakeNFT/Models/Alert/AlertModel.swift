//
//  AlertModel.swift
//  FakeNFT
//
//  Created by Aliaksandr Charnyshou on 14.12.2024.
//

import UIKit

struct AlertModel {

    let title: String
    let message: String?
    let buttons: [AlertButton<Void>]
    let preferredStyle: UIAlertController.Style

    static var urlParsingError: AlertModel {
        AlertModel(
            title: L.Profile.Alert.urlError,
            message: nil,
            buttons: [
                AlertButton(
                    text: L.Alert.ok,
                    style: .default,
                    completion: {}
                )
            ],
            preferredStyle: .alert
        )
    }

    static func confirmChanging(
        agreeCompletion: @escaping () -> Void,
        cancelCompletion: @escaping () -> Void
    ) -> AlertModel {
        AlertModel(
            title: L.Profile.Alert.saveChanges,
            message: nil,
            buttons: [
                AlertButton(
                    text: L.Alert.yes,
                    style: .default,
                    completion: agreeCompletion
                ),
                AlertButton(
                    text: L.Alert.no,
                    style: .destructive,
                    completion: cancelCompletion
                )
            ],
            preferredStyle: .alert
        )
    }

}
