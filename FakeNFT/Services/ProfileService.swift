//
//  ProfileService.swift
//  FakeNFT
//
//  Created by MacBook Pro 15 on 14.01.2025.
//

import Foundation

// MARK: - ProfileServiceProtocol

protocol ProfileServiceProtocol {
    func loadProfile(completion: @escaping (Result<ProfileModel, Error>) -> Void)
    func sendExamplePutRequest(
        name: String,
        avatar: String,
        likes: [String],
        description: String,
        website: String,
        completion: @escaping ProfilePutCompletion
    )
}

typealias ProfileCompletion = (Result<ProfileModel, Error>) -> Void
typealias ProfilePutCompletion = (Result<ProfileModel, Error>) -> Void

// MARK: - ProfileService

struct ProfileService: ProfileServiceProtocol {
    
    // MARK: - Private properties
    
    private let networkClient: NetworkClient
    private let storageService: StorageService
    
    // MARK: - Initializers
    
    init(
        networkClient: NetworkClient,
        storageService: StorageService
    ) {
        self.storageService = storageService
        self.networkClient = networkClient
    }
    
    // MARK: - Public methods
    
    func loadProfile(completion: @escaping ProfileCompletion) {
        
        if let profile = storageService.getProfile() {
            completion(.success(profile))
            return
        }
        
        let request = GetProfileRequest()
        networkClient.send(request: request, type: ProfileModel.self) { result in
            switch result {
            case .success(let model):
                self.storageService.saveProfile(profile: model)
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func sendExamplePutRequest(name: String,
                               avatar: String,
                               likes: [String],
                               description: String,
                               website: String,
                               completion: @escaping ProfilePutCompletion) {
        let dto = ChangeProfileDtoObject(name: name, avatar: avatar, likes: likes, description: description, website: website)
        let request = ChangeProfileRequest(dto: dto)
        networkClient.send(request: request, type: ProfileModel.self) { result in
            switch result {
            case .success(let profileResponse):
                self.storageService.saveProfile(profile: profileResponse)
                completion(.success(profileResponse))
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
