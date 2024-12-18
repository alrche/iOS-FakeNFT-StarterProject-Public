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

    var onProfileInfoChanged: (() -> Void)? {
        didSet {
            storageService.onProfileInfoChanged = onProfileInfoChanged
        }
    }
    var onFetchError: ((String) -> Void)?
    var onEditError: ((String) -> Void)?

    var model: ProfileModel? {
        storageService.profile
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
    private let storageService: StorageService
    private var profileObservation: NSKeyValueObservation?

    // MARK: - Initializers

    init(
        profileService: ProfileServiceProtocol = ProfileService(),
        storageService: StorageService = StorageService.shared
    ) {
        self.storageService = storageService
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
        guard storageService.profile != profileModel else { return }
        storageService.profile = profileModel
        onProfileInfoChanged?()
    }

}
