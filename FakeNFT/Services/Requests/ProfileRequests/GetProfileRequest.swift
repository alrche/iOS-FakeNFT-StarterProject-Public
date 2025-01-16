//
//  GetProfileRequest.swift
//  FakeNFT
//
//  Created by Doroteya Galbacheva on 14.01.2025.
//

import Foundation

struct GetProfileRequest: NetworkRequest {
    
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/profile/1")
    }
    
    var httpMethod: HttpMethod {
        .get
    }
    
    var dto: Dto?
}
