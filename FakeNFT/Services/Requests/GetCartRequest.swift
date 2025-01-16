//
//  GetCartRequest.swift
//  FakeNFT
//
//  Created by Богдан Топорин on 19.12.2024.
//  Created by Doroteya Galbacheva on 14.01.2025.
//

import Foundation

struct NFTOrderRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/orders/1")
    }
    var dto: (any Dto)?
}

struct GetCartRequest: NetworkRequest {

    var endpoint: URL? {
        Endpoint.cart.url
    }

    var httpMethod: HttpMethod {
        .get
    }

    var dto: Dto?
}

