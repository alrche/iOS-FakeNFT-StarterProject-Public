//
//  CartModel.swift
//  FakeNFT
//
//  Created by Богдан Топорин on 19.12.2024.
//

import Foundation


struct Order: Codable {
  let id: String
  let nfts: [String]
}

struct CartModel: Codable,Equatable {
    let id: String
    let nfts: [String]
}
