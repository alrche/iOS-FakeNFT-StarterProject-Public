//
//  AlertModel+Profile.swift
//  FakeNFT
//
//  Created by Aliaksandr Charnyshou on 15.12.2024.
//

import UIKit

struct AlertModelPlusProfile {

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
