//
//  CartService.swift
//  FakeNFT
//
//  Created by Богдан Топорин on 19.12.2024.
//

import Foundation

final class  CartService {

    // MARK: - Public methods
    static func fetchCart(completion: @escaping (Result<CartModel, Error>) -> Void) {
        assert(Thread.isMainThread)
        let request = GetCartRequest()
        DefaultNetworkClient().send(request: request, type: CartModel.self) { result in
            switch result {
            case .success(let model):
                CartService.updateCartIfNeeded(cartModel: model)
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    // MARK: - Private methods
    private static func updateCartIfNeeded(cartModel: CartModel) {
        let userDefaults = UserDefaults.standard
        if userDefaults.cart != cartModel {
            userDefaults.cart = cartModel
            userDefaults.cartLastChangeTime = Int(Date().timeIntervalSince1970)
        }
    }

    func getNFT(
            id: String,
            completion: @escaping (Result<CartItemModel, Error>) -> Void
        ) {
            let nftRequest = NFTRequest(id: id)
            DefaultNetworkClient().send(request: nftRequest, type: CartItemModel.self) { result in
                switch result {
                case .success(let model):
                    completion(.success(model))
                    print("Successfully fetched NFT: \(model)")
                case .failure(let error):
                    completion(.failure(error))
                    print("Error fetching NFT: \(error.localizedDescription)")
                }
            }
        }

        func getNFTs(completion: @escaping (Result<[CartNFTModel], Error>) -> Void) {
            guard let cart = UserDefaults.standard.cart else { return }
            var nfts: [CartNFTModel?] = Array(repeating: nil, count: cart.nfts.count)
            let dispatchGroup = DispatchGroup()
            let dispatchQueue = DispatchQueue(label: "loading_nfts_queue")
            for (index, nftId) in cart.nfts.enumerated() {
                dispatchGroup.enter()
                getNFT(id: nftId) { [weak self] result in
                    switch result {
                    case .success(_):
                            switch result {
                            case .success(let nftModel):
                                dispatchQueue.async {
                                    guard let self = self else {return}
                                    nfts[index] = CartNFTModel(image: nftModel.images[0],
                                                           name: self.getNameFromImage(nftModel.images[0]),
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

        // MARK: - Private methods

        private func getNameFromImage(_ imageString: String) -> String {
            let arrayString = imageString.split(separator: "/")
            return String(arrayString[arrayString.count - 2])
        }
}
