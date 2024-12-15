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

    private var profileObservation: NSKeyValueObservation?
    private var userDefaults: UserDefaults {
        UserDefaults.standard
    }

    // MARK: - Public methods

    func viewDidLoad() {
        registerProfileLastChangeTimeObserver()
        fetchProfile()
    }

    func fetchProfile() {
        ProfileService.fetchProfile { [weak self] result in
            switch result {
            case .success: break
            case .failure(let error): self?.onFetchError?(error.localizedDescription)
            }
        }
    }

    func editProfile(editProfileModel: EditProfileModel) {
        ProfileService.editProfile(editProfileModel) { [weak self] result in
            switch result {
            case .success: break
            case .failure(let error): self?.onEditError?(error.localizedDescription)
            }
        }
    }

    // MARK: - Private methods
    
    func registerProfileLastChangeTimeObserver() {
        profileObservation = userDefaults.observe(
            \.profileLastChangeTime,
             options: []
        ) { [weak self] _, _ in
            guard let self else { return }
            self.onProfileInfoChanged?()
        }
    }

}
