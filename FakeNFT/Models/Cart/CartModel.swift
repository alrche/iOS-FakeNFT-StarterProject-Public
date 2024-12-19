//
//  CartModel.swift
//  FakeNFT
//
//  Created by Богдан Топорин on 19.12.2024.
//

import Foundation

struct CartModel: Codable,Equatable {
    let id: String
    let nfts: [String] 
}
