//
//  ProfilePutForCatalog.swift
//  FakeNFT
//
//  Created by Aliaksandr Charnyshou on 16.01.2025.
//

import Foundation

struct ProfilePutForCatalog: NetworkRequest {
    var endpoint: URL? {
        Endpoint.profile.url
    }

    var httpMethod: HttpMethod = .put

    var dto: Dto?
}




struct ProfileDtoObject: Dto {
    let likes: [String]
    let avatar: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case likes = "likes"
        case avatar = "avatar"
        case name = "name"
    }

    func asDictionary() -> [String : String] {
        [
            CodingKeys.likes.rawValue: likes.isEmpty ? "" : likes.joined(separator:", "),
            CodingKeys.avatar.rawValue: avatar,
            CodingKeys.name.rawValue: name
        ]
    }
}
