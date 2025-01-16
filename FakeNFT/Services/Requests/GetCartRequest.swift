//
//  GetCartRequest.swift
//  FakeNFT
//
//  Created by Богдан Топорин on 19.12.2024.
//

import Foundation

struct GetCartRequest: NetworkRequest {

    var endpoint: URL? {
        Endpoint.cart.url
    }

    var httpMethod: HttpMethod {
        .get
    }

    var dto: Dto?
}

