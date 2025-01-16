//
//  GetCurrenciesRequest.swift
//  FakeNFT
//
//  Created by Богдан Топорин on 27.12.2024.
//


import Foundation

struct GetCurrenciesRequest: NetworkRequest {

    var endpoint: URL? {
        Endpoint.currency.url
    }

    var httpMethod: HttpMethod {
        .get
    }

    var dto: Dto?
}
