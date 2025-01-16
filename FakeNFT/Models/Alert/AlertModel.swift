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

    static func sortActionSheet(
        priceCompletion: @escaping () -> Void,
        ratingCompletion: @escaping () -> Void,
        nameCompletion: @escaping () -> Void
    ) -> AlertModel {
        AlertModel(
            title: L.Alert.Sort.title,
            message: nil,
            buttons: [
                AlertButton(
                    text: L.Alert.Sort.price,
                    style: .default,
                    completion: priceCompletion
                ),
                AlertButton(
                    text: L.Alert.Sort.rating,
                    style: .default,
                    completion: ratingCompletion
                ),
                AlertButton(
                    text: L.Alert.Sort.name,
                    style: .default,
                    completion: nameCompletion
                ),
                AlertButton(
                    text: L.Alert.close,
                    style: .cancel,
                    completion: {}
                )
            ],
            preferredStyle: .actionSheet
        )
    }
    
    
    static func paymentFailedAlert(
            retryCompletion: @escaping () -> Void,
            cancelCompletion: @escaping () -> Void
        ) -> AlertModel {
            return AlertModel(
                title: L.Cart.failurePay,
                message: nil,
                buttons: [
                    AlertButton(
                        text: L.Alert.cancel,
                        style: .default,
                        completion: cancelCompletion
                    ),
                    AlertButton(
                        text: L.Alert.repeat,
                        style: .cancel,
                        completion: retryCompletion
                    )
                ],
                preferredStyle: .alert
            )
        }

}
