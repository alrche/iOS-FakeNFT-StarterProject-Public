//
//  ProfileModel.swift
//  FakeNFT
//
//  Created by Aliaksandr Charnyshou on 14.12.2024.
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
