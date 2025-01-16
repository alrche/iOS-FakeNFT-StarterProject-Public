//
//  CatalogViewModel.swift
//  FakeNFT
//
//  Created by Doroteya Galbacheva on 17.12.2024.
//

import UIKit

protocol CatalogViewModelProtocol: AnyObject {
    func fetchCollections(completion: @escaping () -> Void)
    func numberOfCollections() -> Int
    func collection(at index: Int) -> NFTRowModel
}

final class CatalogViewModel: CatalogViewModelProtocol {
    private var collections: [NFTRowModel] = []
    
    func fetchCollections(completion: @escaping () -> Void) {
        // Здесь будет запрос к сервису для загрузки данных
        // После загрузки данных обновим массив collections
        guard let image = UIImage(named: "peach") else {return}
        collections = [NFTRowModel(image: image, name: "Peach", count: 11), 
                       NFTRowModel(image: image, name: "Peach", count: 11),
                       NFTRowModel(image: image, name: "Peach", count: 11),
                       NFTRowModel(image: image, name: "Peach", count: 11),
                       NFTRowModel(image: image, name: "Peach", count: 11)]
        completion()
    }
    
    func numberOfCollections() -> Int {
        return collections.count
    }
    
    func collection(at index: Int) -> NFTRowModel {
        return collections[index]
    }
}
