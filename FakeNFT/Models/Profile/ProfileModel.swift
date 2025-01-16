//
//  ProfileModel.swift
//  FakeNFT
//
//  Created by MacBook Pro 15 on 14.01.2025.
//

import Foundation

struct ProfileModel: Codable, Equatable {
    var name: String
    var avatar: String
    var description: String
    var website: String
    var nfts: [String]
    var likes: [String]
    let id: String
}
