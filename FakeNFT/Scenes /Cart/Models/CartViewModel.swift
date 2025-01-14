//
//  CartViewModel.swift
//  FakeNFT
//
//  Created by Богдан Топорин on 19.12.2024.
//

import Foundation

final class CartViewModel {
    
    // MARK: - Public properties
    
    private(set) var nftList: [CartNFTModel]? {
        didSet {
            onNFTListLoaded?()
        }
    }
    var onNFTListLoaded: (() -> Void)?
    var onNFTListLoadError: ((String) -> Void)?
    
    // MARK: - Private properties
    
    private let cartService = CartService()
    private var userDefaults: UserDefaults {
        UserDefaults.standard
    }
    private var cartModel: CartModel?
    
    // MARK: - Public methods
    
    func viewDidLoad() {
        fetchCartAndNFTs()
    }
    
    func sortByPrice() {
        nftList = nftList?.sorted { $0.price < $1.price }
    }
    
    func sortByRating() {
        nftList = nftList?.sorted { $0.rating > $1.rating }
    }
    
    func sortByName() {
        nftList = nftList?.sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
    }
    
    func updateNFTList(_ updatedList: [CartNFTModel]) {
            nftList = updatedList
        }
    
    // MARK: - Private methods
    
    private func fetchCartAndNFTs() {
        CartService.fetchCart { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let cartModel):
                self.cartModel = cartModel
                self.fetchNFTs()
            case .failure(let error):
                self.onNFTListLoadError?("Failed to fetch cart: \(error.localizedDescription)")
            }
        }
    }
    
    private func fetchNFTs() {
        guard let cartModel = cartModel else {
            onNFTListLoadError?("Cart is not loaded")
            return
        }
        
        cartService.getNFTs { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let nftModels):
                self.nftList = nftModels
            case .failure(let error):
                self.onNFTListLoadError?("Failed to fetch NFTs: \(error.localizedDescription)")
            }
        }
    }
}
