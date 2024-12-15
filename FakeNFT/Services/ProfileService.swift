//
//  ProfileService.swift
//  FakeNFT
//
//  Created by Aliaksandr Charnyshou on 14.12.2024.
//

import Foundation

// MARK: - ProfileService

struct ProfileService {

    // MARK: - Public methods

    static func fetchProfile(completion: @escaping (Result<ProfileModel, Error>) -> Void) {
        assert(Thread.isMainThread)
        let request = GetProfileRequest()
        DefaultNetworkClient().send(request: request, type: ProfileModel.self) { result in
            switch result {
            case .success(let model):
                ProfileService.updateProfileIfNeeded(profileModel: model)
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    static func editProfile(
        _ editProfileModel: EditProfileModel,
        completion: @escaping (Result<ProfileModel, Error>) -> Void
    ) {
        assert(Thread.isMainThread)
        let request = ChangeProfileRequest(model: editProfileModel)
        DefaultNetworkClient().send(request: request, type: ProfileModel.self) { result in
            switch result {
            case .success(let model):
                ProfileService.updateProfileIfNeeded(profileModel: model)
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    // MARK: - Private methods
    
    private static func updateProfileIfNeeded(profileModel: ProfileModel) {
        let userDefaults = UserDefaults.standard
        if userDefaults.profile != profileModel {
            userDefaults.profile = profileModel
            userDefaults.profileLastChangeTime = Int(Date().timeIntervalSince1970)
        }
    }

}
