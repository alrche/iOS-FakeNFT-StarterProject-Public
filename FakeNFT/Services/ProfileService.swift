//
//  ProfileService.swift
//  FakeNFT
//
//  Created by Aliaksandr Charnyshou on 14.12.2024.
//

import Foundation

// MARK: - ProfileServiceProtocol

protocol ProfileServiceProtocol {
    func fetchProfile(completion: @escaping (Result<ProfileModel, Error>) -> Void)
    func editProfile(
        _ editProfileModel: EditProfileModel,
        completion: @escaping (Result<ProfileModel, Error>) -> Void
    )
    func getNFT(
        id: String,
        completion: @escaping (Result<NFTNetworkModel, Error>) -> Void
    )
    func getNFTs(completion: @escaping (Result<[NFTModel], Error>) -> Void)
    func getFavouriteNFTs(completion: @escaping (Result<[FavouriteNFTModel], Error>) -> Void)
    func setLikes(
        _ likesModel: LikesModel,
        completion: @escaping (Result<ProfileModel, Error>) -> Void
    )
}

// MARK: - ProfileService

struct ProfileService: ProfileServiceProtocol {

    // MARK: - Private properties

    private let networkClient: NetworkClient
    private let storageService: StorageService

    // MARK: - Initializers

    init(
        networkClient: NetworkClient = DefaultNetworkClient(),
        storageService: StorageService = StorageService.shared
    ) {
        self.storageService = storageService
        self.networkClient = networkClient
    }

    // MARK: - Public methods

    func fetchProfile(completion: @escaping (Result<ProfileModel, Error>) -> Void) {
        let request = GetProfileRequest()
        networkClient.send(request: request, type: ProfileModel.self) { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func editProfile(
        _ editProfileModel: EditProfileModel,
        completion: @escaping (Result<ProfileModel, Error>) -> Void
    ) {
        let request = ChangeProfileRequest(model: editProfileModel)
        networkClient.send(request: request, type: ProfileModel.self) { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getNFT(
        id: String,
        completion: @escaping (Result<NFTNetworkModel, Error>) -> Void
    ) {
        let nftRequest = NFTRequest(id: id)
        networkClient.send(request: nftRequest, type: NFTNetworkModel.self) { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getNFTs(completion: @escaping (Result<[NFTModel], Error>) -> Void) {
        guard let profile = storageService.profile else { return }
        var nfts: [NFTModel?] = Array(repeating: nil, count: profile.nfts.count)
        let dispatchGroup = DispatchGroup()
        let dispatchQueue = DispatchQueue(label: "loading_nfts_queue")
        for (index, nftId) in profile.nfts.enumerated() {
            dispatchGroup.enter()
            getNFT(id: nftId) { result in
                switch result {
                case .success(_):
                        switch result {
                        case .success(let nftModel):
                            dispatchQueue.async {
                                nfts[index] = NFTModel(image: nftModel.images[0],
                                                       // TODO: заменить на nftModel.name после фикса API
                                                       name: self.getNameFromImage(nftModel.images[0]),
                                                       // TODO: заменить на nftModel.author после фикса API
                                                       authorName: nftModel.name,
                                                       rating: nftModel.rating,
                                                       price: nftModel.price)
                                dispatchGroup.leave()
                            }
                        case .failure(let error):
                            completion(.failure(error))
                            dispatchGroup.leave()
                        }
                case .failure(let error):
                    completion(.failure(error))
                    dispatchGroup.leave()
                }
            }
        }
        dispatchGroup.notify(queue: dispatchQueue) {
            completion(.success(nfts.compactMap { $0 }))
        }
    }

    func getFavouriteNFTs(completion: @escaping (Result<[FavouriteNFTModel], Error>) -> Void) {
        guard let profile = storageService.profile else { return }
        var nfts: [FavouriteNFTModel?] = Array(repeating: nil, count: profile.likes.count)
        let dispatchGroup = DispatchGroup()
        let dispatchQueue = DispatchQueue(label: "loading_fav_nfts_queue")
        for (index, nftId) in profile.likes.enumerated() {
            dispatchGroup.enter()
            getNFT(id: nftId) { result in
                switch result {
                case .success(let nftModel):
                    dispatchQueue.async {
                        nfts[index] = FavouriteNFTModel(
                            id: nftModel.id,
                            image: nftModel.images[0],
                            // TODO: заменить на nftModel.name после фикса API
                            name: self.getNameFromImage(nftModel.images[0]),
                            rating: nftModel.rating,
                            price: nftModel.price
                        )
                        dispatchGroup.leave()
                    }
                case .failure(let error):
                    completion(.failure(error))
                    dispatchGroup.leave()
                }
            }
        }
        dispatchGroup.notify(queue: dispatchQueue) {
            completion(.success(nfts.compactMap { $0 }))
        }
    }

    func setLikes(
        _ likesModel: LikesModel,
        completion: @escaping (Result<ProfileModel, Error>) -> Void
    ) {
        let request = SetLikesRequest(model: likesModel)
        networkClient.send(request: request, type: ProfileModel.self) { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    // MARK: - Private methods

    // TODO: удалить метод получения имени NFT по URL картинки после фикса API
    private func getNameFromImage(_ imageString: String) -> String {
        let arrayString = imageString.split(separator: "/")
        return String(arrayString[arrayString.count - 2])
    }

}
