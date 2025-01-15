//
//  NFTModel.swift
//  FakeNFT
//
//  Created by Aliaksandr Charnyshou on 15.12.2024.
//

import Foundation

struct NFTModel: Codable, Equatable {
    let image: String
    let name: String
    let authorName: String
    let rating: Int
    let price: Float
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.image == rhs.image &&
        lhs.name == rhs.name &&
        lhs.authorName == rhs.authorName &&
        lhs.rating == rhs.rating &&
        lhs.price == rhs.price
    }
}
