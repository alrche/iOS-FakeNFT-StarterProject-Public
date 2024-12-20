//
//  StorageService.swift
//  FakeNFT
//
//  Created by Aliaksandr Charnyshou on 17.12.2024.
//

import Foundation
import os.log

// MARK: - Private properties

final class StorageService {

    // MARK: - Public  properties

    static let shared = StorageService()
    var onProfileInfoChanged: (() -> Void)?

    var profile: ProfileModel? {
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

    var sortType: SortType {
        get {
            guard
                let sortTypeString = userDefaults.string(forKey: Keys.sortType.rawValue),
                let sortType = SortType(rawValue: sortTypeString)
            else {
                return .byRating
            }
            return sortType
        }
        set {
            userDefaults.setValue(newValue.rawValue, forKey: Keys.sortType.rawValue)
        }
    }

    // MARK: - Private  properties

    private enum Keys: String {
        case profile, sortType
    }

    private let userDefaults = UserDefaults.standard

    // MARK: - Initializers
    
    private init() {}

}
