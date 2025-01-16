//
//  ProfileStorage.swift
//  FakeNFT
//
//  Created by Aliaksandr Charnyshou on 16.01.2025.
//

import Foundation

protocol ProfileStorage: AnyObject {
    func saveProfile(profile: ProfileModel)
    func getProfile() -> ProfileModel?
}

// Пример простого класса, который сохраняет данные из сети
final class ProfileStorageImpl: ProfileStorage {
    private var profile: ProfileModel? = nil

    private let syncQueue = DispatchQueue(label: "sync-nft-queue")

        func saveProfile(profile: ProfileModel) {
            syncQueue.async {
                self.profile = profile
            }
        }

        func getProfile() -> ProfileModel? {
            syncQueue.sync {
                profile
            }
        }
    }
