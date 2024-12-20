//
//  EditProfileModel.swift
//  FakeNFT
//
//  Created by Aliaksandr Charnyshou on 14.12.2024.
//

import Foundation

struct EditProfileModel: Codable, Equatable {
    let name: String
    let avatar: String
    let description: String
    let website: String
}
