//
//  ChangeProfileRequest.swift
//  FakeNFT
//
//  Created by Doroteya Galbacheva on 14.01.2025.
//

import Foundation

struct ChangeProfileRequest: NetworkRequest {
    
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/profile/1")
    }
    var httpMethod: HttpMethod = .put
    var dto: Dto?
}

struct ChangeProfileDtoObject: Dto {
    let name: String
    let avatar: String
    let likes: [String]
    let description: String
    let website: String
    
    enum CodingKeys: String, CodingKey {
        case avatar = "avatar"
        case name = "name"
        case likes = "likes"
        case description
        case website
    }
    
    func asDictionary() -> [String : String] {
        [
            CodingKeys.name.rawValue: name,
            CodingKeys.avatar.rawValue: avatar,
            CodingKeys.likes.rawValue: likes.isEmpty ? "" : likes.joined(separator:", "),
            CodingKeys.description.rawValue: description,
            CodingKeys.website.rawValue: website
            
        ]
    }
}
