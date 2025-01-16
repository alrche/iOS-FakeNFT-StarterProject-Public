//
//  ProfileServiceForCatalog.swift
//  FakeNFT
//
//  Created by Aliaksandr Charnyshou on 16.01.2025.
//

import Foundation

typealias ProfileCompletion = (Result<ProfileModel, Error>) -> Void
typealias ProfilePutCompletion = (Result<ProfileModel, Error>) -> Void

protocol ProfileServiceForCatalog {
    func loadProfile(completion: @escaping ProfileCompletion)
    func sendExamplePutRequest(
        likes: [String],
        avatar: String,
        name: String,
        completion: @escaping ProfilePutCompletion
    )
}

final class ProfileServiceImpl: ProfileServiceForCatalog {
    private let networkClient: NetworkClient
        private let storage: ProfileStorage

        init(networkClient: NetworkClient, storage: ProfileStorage) {
            self.storage = storage
            self.networkClient = networkClient
        }

        func loadProfile(completion: @escaping ProfileCompletion) {

            if let profile = storage.getProfile() {
                completion(.success(profile))
                return
            }

            let request = GetProfileRequest()
            networkClient.send(request: request, type: ProfileModel.self) { [weak self] result in
                switch result {
                case .success(let profile):
                    self?.storage.saveProfile(profile: profile)
                    completion(.success(profile))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }

        func sendExamplePutRequest(likes: [String],
                                   avatar: String,
                                   name: String,
                                   completion: @escaping ProfilePutCompletion) {
            let dto = ProfileDtoObject(likes: likes, avatar: avatar, name: name)
            let request = ProfilePutForCatalog(dto: dto)
            networkClient.send(request: request, type: ProfileModel.self) { [weak self] result in
                switch result {
                case .success(let profileResponse):
                    self?.storage.saveProfile(profile: profileResponse)
                    completion(.success(profileResponse))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
