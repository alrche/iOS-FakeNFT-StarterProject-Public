//
//  GetCartRequest.swift
//  FakeNFT
//
//  Created by Doroteya Galbacheva on 14.01.2025.
//

import Foundation

struct GetCartRequest: NetworkRequest {
    
    var endpoint: URL? {
        Endpoint.cart.url
    }
    
    var httpMethod: HttpMethod {
        .get
    }
    
    var dto: (any Dto)?
}

