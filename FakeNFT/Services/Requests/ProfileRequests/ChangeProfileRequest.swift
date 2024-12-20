//
//  ChangeProfileRequest.swift
//  FakeNFT
//
//  Created by Aliaksandr Charnyshou on 14.12.2024.
//

import Foundation

struct ChangeProfileRequest: NetworkRequest {
    let model: EditProfileModel
    
    var endpoint: URL? {
        Endpoint.profile.url
    }
    
    var httpMethod: HttpMethod {
        .put
    }
    
    var dto: Dto? {
        ChangeProfileDtoObject(name: model.name,
                               avatar: model.avatar,
                               description: model.description,
                               website: model.website)
    }
    
    init(model: EditProfileModel) {
        self.model = model
    }
    
}

struct ChangeProfileDtoObject: Dto {
    let name: String
    let avatar: String
    let description: String
    let website: String

    
    enum CodingKeys: String, CodingKey {
        case name
        case avatar
        case description
        case website
    }
    
    func asDictionary() -> [String : String] {
        [
            CodingKeys.name.rawValue: name,
            CodingKeys.avatar.rawValue: avatar,
            CodingKeys.description.rawValue: description,
            CodingKeys.website.rawValue: website
        ]
    }
}
