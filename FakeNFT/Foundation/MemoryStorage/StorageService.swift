//
//  ProfileStorage.swift
//  FakeNFT
//
//  Created by MacBook Pro 15 on 14.01.2025.
//

import Foundation
import os.log

protocol ProfileStorage: AnyObject {
    func saveProfile(profile: ProfileModel)
    func getProfile() -> ProfileModel?
}

final class StorageService {
    
    // MARK: - Public  properties
    
    static let shared = StorageService()
    var onProfileInfoChanged: (() -> Void)?
    
    private let syncQueue = DispatchQueue(label: "sync-nft-queue")
    
    private var profile: ProfileModel? {
        get {
            guard let data = userDefaults.data(forKey: Keys.profile.rawValue),
                  let record = try? JSONDecoder().decode(ProfileModel.self, from: data) else {
                return nil
            }
            return record
        }
        set {
            guard let data = try? JSONEncoder().encode(newValue) else {
                os_log("Невозможно сохранить результат", log: .default, type: .error)
                return
            }
            userDefaults.set(data, forKey: Keys.profile.rawValue)
            onProfileInfoChanged?()
        }
    }
    
    // MARK: - Private  properties
    
    private enum Keys: String {
        case profile, sortType
    }
    
    private let userDefaults = UserDefaults.standard
    
    // MARK: - Initializers
    
    init() {}
}

extension StorageService: ProfileStorage {
    
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
