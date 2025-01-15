//
//  Order.swift
//  FakeNFT
//
//  Created by Doroteya Galbacheva on 14.01.2025.
//

import Foundation


struct Order: Codable {
  let id: String
  let nfts: [String]
}
