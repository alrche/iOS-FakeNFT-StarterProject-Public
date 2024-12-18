//
//  SetLikesRequest.swift
//  FakeNFT
//
//  Created by Aliaksandr Charnyshou on 17.12.2024.
//

import Foundation

struct SetLikesRequest: NetworkRequest {

    let model: LikesModel

    var endpoint: URL? {
        Endpoint.profile.url
    }

    var httpMethod: HttpMethod {
        .put
    }

    var dto: Dto? {
        SetLikesDtoObject(likes: model.likes)
    }

    init(model: LikesModel) {
        self.model = model
    }

}

struct SetLikesDtoObject: Dto {
    let likes: [String]

    enum CodingKeys: String, CodingKey {
        case likes = "likes"
    }

    func asDictionary() -> [String : String] {
        [
            CodingKeys.likes.rawValue: likes.isEmpty ? "" : likes.joined(separator:", ")
        ]
    }
}
