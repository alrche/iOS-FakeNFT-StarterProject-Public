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
        ChangeProfileDtoObject(param1: model.name,
                               param2: model.avatar,
                               param3: model.description,
                               param4: model.website)
    }
    
    init(model: EditProfileModel) {
        self.model = model
    }
    
}

struct ChangeProfileDtoObject: Dto {
    let param1: String
    let param2: String
    let param3: String
    let param4: String
    
    
    enum CodingKeys: String, CodingKey {
        case param1 = "name"
        case param2 = "avatar"
        case param3 = "description"
        case param4 = "website"
    }
    
    func asDictionary() -> [String : String] {
        [
            CodingKeys.param1.rawValue: param1,
            CodingKeys.param2.rawValue: param2,
            CodingKeys.param3.rawValue: param3,
            CodingKeys.param4.rawValue: param4
        ]
    }
}
