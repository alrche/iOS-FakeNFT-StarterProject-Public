//
//  CurrencyModel.swift
//  FakeNFT
//
//  Created by Богдан Топорин on 27.12.2024.
//

import Foundation

struct CurrencyModel: Codable, Equatable {
    let title: String
    let name: String
    let image: String
    let id: String
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.image == rhs.image &&
        lhs.name == rhs.name &&
        lhs.title == rhs.title &&
        lhs.id == rhs.id
    }
}
