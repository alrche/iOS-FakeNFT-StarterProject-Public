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

    static func myNFTLoadError(message: String) -> AlertModel {
        baseLoadError(
            title: L.Profile.MyNFT.Alert.fetchError,
            message: message
        )
    }

    static func favouriteNFTLoadError(message: String) -> AlertModel {
        baseLoadError(
            title: L.Profile.FavouriteNFT.Alert.fetchError,
            message: message
        )
    }

    static func unlikeError(message: String) -> AlertModel {
        baseLoadError(
            title: L.Profile.FavouriteNFT.Alert.unlikeError,
            message: message
        )
    }

    private static func baseLoadError(title: String, message: String) -> AlertModel {
        AlertModel(
            title: title,
            message: message,
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
}
