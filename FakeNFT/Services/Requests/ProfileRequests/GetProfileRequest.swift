//
//  GetProfileRequest.swift
//  FakeNFT
//
//  Created by Aliaksandr Charnyshou on 14.12.2024.
//

import Foundation

struct GetProfileRequest: NetworkRequest {
    
    var endpoint: URL? {
        Endpoint.profile.url
    }
    
    var httpMethod: HttpMethod {
        .get
    }

    var dto: Dto?
}
