//
//  ProfileViewModel.swift
//  FakeNFT
//
//  Created by Aliaksandr Charnyshou on 14.12.2024.
//

import Foundation

// MARK: - ProfileViewModel

final class ProfileViewModel {

    // MARK: - Public properties

    var onProfileInfoChanged: (() -> Void)?
    var onFetchError: ((String) -> Void)?
    var onEditError: ((String) -> Void)?

    var model: ProfileModel? {
        userDefaults.profile
    }

    var cells: [ProfileTableViewCells] {
        [
            .myNFT(model?.nfts.count ?? 0),
            .favouriteNFT(model?.likes.count ?? 0),
            .about
        ]
    }

    // MARK: - Private properties

    private let profileService: ProfileServiceProtocol
    private var userDefaults: UserDefaults {
        UserDefaults.standard
    }

    // MARK: - Initializers

    init(profileService: ProfileServiceProtocol = ProfileService()) {
        self.profileService = profileService
    }

    // MARK: - Public methods

    func fetchProfile() {
        profileService.fetchProfile { [weak self] result in
            switch result {
            case .success(let model): self?.updateProfileIfNeeded(profileModel: model)
            case .failure(let error): self?.onFetchError?(error.localizedDescription)
            }
        }
    }

    func editProfile(editProfileModel: EditProfileModel) {
        profileService.editProfile(editProfileModel) { [weak self] result in
            switch result {
            case .success(let model): self?.updateProfileIfNeeded(profileModel: model)
            case .failure(let error): self?.onEditError?(error.localizedDescription)
            }
        }
    }

    // MARK: - Private methods
    
    private func updateProfileIfNeeded(profileModel: ProfileModel) {
        guard userDefaults.profile != profileModel else { return }
        userDefaults.profile = profileModel
        onProfileInfoChanged?()
    }

}
