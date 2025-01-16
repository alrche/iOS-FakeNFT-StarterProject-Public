//
//  CurrencyModel.swift
//  FakeNFT
//
//  Created by Doroteya Galbacheva on 14.01.2025.
//

import Foundation

struct CurrencyModel: Codable {
    let title: String
    let name: String
    let image: URL
    let id: String
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.image == rhs.image &&
        lhs.name == rhs.name &&
        lhs.title == rhs.title &&
        lhs.id == rhs.id
    }
}
