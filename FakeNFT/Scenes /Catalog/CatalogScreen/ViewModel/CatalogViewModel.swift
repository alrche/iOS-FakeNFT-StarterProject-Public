//
//  CatalogViewModel.swift
//  FakeNFT
//
//  Created by Doroteya Galbacheva on 17.12.2024.
//

import Foundation

protocol CatalogViewModelProtocol: AnyObject {
    func fetchCollections(completion: @escaping () -> Void)
    
    func numberOfCollections() -> Int
    func collection(at index: Int) -> NFTModelCatalog
    func getProfile(completion: @escaping () -> Void)
    var reloadTableView: (() -> Void)? { get set }
    var profile: ProfileModel? { get set }
    var order: CartModel? { get set }
    
    func sortByName()
    func sortByCount()
}

final class CatalogViewModel: CatalogViewModelProtocol {
    
    private let catalogModel = CatalogService(networkClient: DefaultNetworkClient(), storage: NftStorageImpl())
    private let networkClient = DefaultNetworkClient()
    private let orderService = OrderServiceImpl(networkClient: DefaultNetworkClient())
    private let sortOptionKey = "sortOptionKey"
    private var catalog: [NFTModelCatalog] = []
    var profile: ProfileModel?
    var  order: CartModel?
    var reloadTableView: (() -> Void)?
    
    func fetchCollections(completion: @escaping () -> Void) {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        
        catalogModel.loadCatalog { [weak self] (result: Result<NFTsModelCatalog, any Error>) in
            guard let self = self else {return}
            switch result {
            case .success(let catalog):
                self.catalog = catalog
                self.applySavedSortOption()
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        dispatchGroup.leave()
    }
    
    func numberOfCollections() -> Int {
        return catalog.count
    }
    
    func collection(at index: Int) -> NFTModelCatalog {
        return catalog[index]
    }
    
    func sortByName() {
        catalog.sort { $0.name < $1.name }
        saveSortOption(.name)
        reloadTableView?()
    }
    
    func sortByCount() {
        catalog.sort { $0.nfts.count > $1.nfts.count }
        saveSortOption(.count)
        reloadTableView?()
    }
    
    private func saveSortOption(_ option: SortOption) {
        UserDefaults.standard.set(option.rawValue, forKey: sortOptionKey)
    }
    
    private func applySavedSortOption() {
        let savedOption = UserDefaults.standard.string(forKey: sortOptionKey)
        switch savedOption {
        case SortOption.name.rawValue:
            sortByName()
        case SortOption.count.rawValue:
            sortByCount()
        default:
            break
        }
    }
    
    func getProfile(completion: @escaping () -> Void) {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        loadProfile { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(_):
                loadOrder {
                    completion()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        dispatchGroup.leave()
    }
    
    func loadProfile(completion: @escaping ProfileCompletion) {
        let request = GetProfileRequest()
        networkClient.send(request: request, type: ProfileModel.self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let newProfile):
                self.profile = newProfile
                completion(.success(newProfile))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func loadOrder(completion: @escaping () -> Void) {
        orderService.loadOrder { [weak self] result in
            switch result {
            case .success(let order):
                self?.order = order
                completion()
            case .failure(let error):
                print("Failed to load order: \(error.localizedDescription)")
            }
        }
    }
}
