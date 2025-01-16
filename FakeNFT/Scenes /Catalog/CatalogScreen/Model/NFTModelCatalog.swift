//
//  NFTRowForTableView.swift
//  FakeNFT
//
//  Created by Doroteya Galbacheva on 17.12.2024.
//

import UIKit

struct NFTModelCatalog: Codable {
    let createdAt: String
    let name: String
    let cover: URL
    let nfts: [String]
    let description: String
    let author: String
    let id: String
}

typealias NFTsModelCatalog = [NFTModelCatalog]
typealias NFTsModelCatalogCompletion = (Result<NFTsModelCatalog, Error>) -> Void
