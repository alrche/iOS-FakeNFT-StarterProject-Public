//
//  GetProfileRequest.swift
//  FakeNFT
//
//  Created by Doroteya Galbacheva on 14.01.2025.
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
