//
//  CartNFTModel.swift
//  FakeNFT
//
//  Created by Богдан Топорин on 19.12.2024.
//

import Foundation

struct CartNFTModel: Codable, Equatable {
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
