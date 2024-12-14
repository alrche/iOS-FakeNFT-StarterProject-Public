//
//  AlertModel.swift
//  FakeNFT
//
//  Created by Aliaksandr Charnyshou on 14.12.2024.
//

import UIKit

// MARK: - AlertModel
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
    static func profileFetchError(
        message: String,
        tryAgainCompletion: @escaping () -> Void
    ) -> AlertModel {
        AlertModel(
            title: L.Profile.Alert.fetchError,
            message: message,
            buttons: [
                AlertButton(
                    text: L.Alert.tryAgain,
                    style: .default,
                    completion: tryAgainCompletion
                )
            ],
            preferredStyle: .alert
        )
    }

    static func profileEditError(
        message: String,
        okCompletion: @escaping () -> Void
    ) -> AlertModel {
        AlertModel(
            title: L.Profile.Alert.editError,
            message: message,
            buttons: [
                AlertButton(
                    text: L.Alert.ok,
                    style: .default,
                    completion: okCompletion
                )
            ],
            preferredStyle: .alert
        )
    }

}
