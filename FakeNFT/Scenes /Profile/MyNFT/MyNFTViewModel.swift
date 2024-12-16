//
//  MyNFTViewModel.swift
//  FakeNFT
//
//  Created by Aliaksandr Charnyshou on 15.12.2024.
//

import Foundation

// MARK: - MyNFTViewModelProtocol

protocol MyNFTViewModelProtocol {
    var nftList: [NFTModel]? { get }
    var onNFTListLoaded: (() -> Void)? { get set }
    var onNFTListLoadError: ((String) -> Void)? { get set }
    var sortType: SortType { get set }
    func viewDidLoad()
}

// MARK: - MyNFTViewModel

final class MyNFTViewModel: MyNFTViewModelProtocol {

    // MARK: - Public properties

    private(set) var nftList: [NFTModel]? {
        didSet {
            onNFTListLoaded?()
        }
    }
    var onNFTListLoaded: (() -> Void)?
    var onNFTListLoadError: ((String) -> Void)?
    var sortType: SortType {
        get { userDefaults.sortType }
        set {
            userDefaults.sortType = newValue
            sortNFTList()
        }
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
    
    func viewDidLoad() {
        fetchNFTs()
    }

    // MARK: - Private methods

    private func fetchNFTs() {
        profileService.getNFTs { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let nftModels):
                self.nftList = nftModels
                sortNFTList()
            case .failure(let error):
                onNFTListLoadError?(error.localizedDescription)
            }
        }
    }

    private func sortNFTList() {
        switch sortType {
        case .byPrice:
            self.nftList?.sort { $0.price < $1.price }
        case .byRating:
            self.nftList?.sort { $0.rating > $1.rating }
        case .byName:
            self.nftList?.sort { $0.name < $1.name }
        }
    }

}
