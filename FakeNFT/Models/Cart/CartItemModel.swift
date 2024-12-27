//
//  CartItemModel.swift
//  FakeNFT
//
//  Created by Богдан Топорин on 19.12.2024.
//

import Foundation

struct CartItemModel: Codable, Equatable {
    let createdAt: String
    let name: String
    let images: [String]
    let rating: Int
    let description: String
    let price: Float
    let author: String
    let id: String
}
