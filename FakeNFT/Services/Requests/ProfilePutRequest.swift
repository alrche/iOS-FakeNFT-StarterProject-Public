//
//  ProfilePutRequest.swift
//  FakeNFT
//
//  Created by Doroteya Galbacheva on 14.01.2025.
//

import Foundation

struct ProfilePutRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/profile/1")
    }
    var httpMethod: HttpMethod = .put
    var dto: Dto?
}

struct ProfileDtoObject: Dto {
    let likes: [String]
    let avatar: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case likes = "likes" //имя поля в запросе будет param_1
        case avatar = "avatar" //имя поля в запросе будет param_2
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
