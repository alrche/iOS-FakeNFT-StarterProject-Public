//
//  CollectionViewModel.swift
//  FakeNFT
//
//  Created by Doroteya Galbacheva on 17.12.2024.
//

import UIKit
import ProgressHUD

protocol CollectionViewModelProtocol: AnyObject {
    func fetchCollections(completion: @escaping () -> Void)
    func numberOfCollections() -> Int
    func collection(at index: Int) -> Nft
    func getPickedCollection() -> NFTModelCatalog
    func getLikes() -> [String]
    func getCart() -> [String]
    func fetchNFTs(completion: @escaping () -> Void)
    func toggleLike(for nftId: String, completion: @escaping () -> Void)
    func toggleCart(for nftId: String, completion: @escaping () -> Void)
}

final class CollectionViewModel: CollectionViewModelProtocol {
    private let collectionModel: CollectionModel
    private var pickedCollection: NFTModelCatalog
    private var NFTsFromCollection: Nfts = []
    private var profile:  ProfileModel? = nil
    private var order: CartModel? = nil
    private var favouriteNFT: [String] = []
    private  var  cartNFT: [String] = []
    var showErrorAlert: ((String) ->  Void)?
    private let profileService = ProfileService(networkClient: DefaultNetworkClient(), storageService:  StorageService())
    private let orderService = OrderServiceImpl(networkClient: DefaultNetworkClient())
    
    init(pickedCollection: NFTModelCatalog, model: CollectionModel,  profile: ProfileModel, order: CartModel) {
        self.collectionModel = model
        self.pickedCollection = pickedCollection
        self.profile = profile
        self.favouriteNFT = profile.likes
        self.order = order
        self.cartNFT =  order.nfts
    }
    
    func fetchCollections(completion: @escaping () -> Void) {
        ProgressHUD.show()
        ProgressHUD.animationType = .circleBarSpinFade
        
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        
        collectionModel.loadCollection(idArrys: pickedCollection.nfts) { [weak self] (result: Result<Nfts, any Error>) in
            guard let self = self else {return}
            switch result {
            case .success(let nfts):
                self.NFTsFromCollection = nfts
                ProgressHUD.dismiss()
                completion()
            case .failure(let error):
                ProgressHUD.showError()
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchNFTs(completion: @escaping () -> Void) {
        
        let dispatchGroup = DispatchGroup()
        let idArray = pickedCollection.nfts
        var nftsArray: Nfts = []
        
        for i in idArray {
            dispatchGroup.enter()
            collectionModel.loadNft(id: i) { (result: (Result<Nft, Error>)) in
                switch result {
                case .success(let nft):
                    nftsArray.append(nft)
                case .failure(let error):
                    ProgressHUD.showError()
                    print(error.localizedDescription)
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.NFTsFromCollection = nftsArray
            completion()
        }
    }
    
    // Методы для получения данных для UI
    func numberOfCollections() -> Int {
        return NFTsFromCollection.count
    }
    
    func collection(at index: Int) -> Nft {
        return NFTsFromCollection[index]
    }
    
    func getPickedCollection() -> NFTModelCatalog {
        return pickedCollection
    }
    
    func getLikes() -> [String] {
        return favouriteNFT
    }
    
    func getCart() -> [String] {
        return cartNFT
    }
    
    func toggleLike(for nftId: String, completion: @escaping () -> Void) {
        guard let profile = profile else { return }
        
        if let index = favouriteNFT.firstIndex(of: nftId) {
            favouriteNFT.remove(at: index)
        } else {
            favouriteNFT.append(nftId)
        }
        
        profileService.sendExamplePutRequest(name: profile.name, avatar: profile.avatar, likes: favouriteNFT, description: profile.description,website: profile.website) { [weak self] result in
            switch result {
            case .success(let updatedProfile):
                self?.profile = updatedProfile
            case .failure(let error):
                self?.showErrorAlert?(error.localizedDescription)
            }
            completion()
        }
    }
    
    func toggleCart(for nftId: String, completion: @escaping () -> Void) {
        if let index = cartNFT.firstIndex(of: nftId) {
            cartNFT.remove(at: index)
        } else {
            cartNFT.append(nftId)
        }
        
        orderService.updateOrder(nftsIds: cartNFT) { [weak self] result in
            switch result {
            case .success(let order):
                self?.order = order
            case .failure(let error):
                self?.showErrorAlert?(error.localizedDescription)
            }
            completion()
        }
    }
}
