//
//  Storage.swift
//  FakeNFT
//
//  Created by Aliaksandr Charnyshou on 14.12.2024.
//

import Foundation

extension UserDefaults {

    private enum Keys: String {
        case profile, profileLastChangeTime
    }

    @objc dynamic var profileLastChangeTime: Int {
        get {
            integer(forKey: Keys.profileLastChangeTime.rawValue)
        }
        set {
            setValue(newValue, forKey: Keys.profileLastChangeTime.rawValue)
        }
    }

    var profile: ProfileModel? {
        get {
            guard let data = data(forKey: Keys.profile.rawValue),
                  let record = try? JSONDecoder().decode(ProfileModel.self, from: data) else {
                return nil
            }
            return record
        }
        set {
            guard let data = try? JSONEncoder().encode(newValue) else {
                print("Невозможно сохранить результат")
                return
            }
            set(data, forKey: Keys.profile.rawValue)
        }
    }

}
