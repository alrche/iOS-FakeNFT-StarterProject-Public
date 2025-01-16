//
//  CurrencyListRequest.swift
//  GetCurrenciesRequest.swift
//  FakeNFT
//
//  Created by Doroteya Galbacheva on 14.01.2025.
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
    
    var dto: (any Dto)?
}

struct GetCurrenciesRequest: NetworkRequest {

    var endpoint: URL? {
        Endpoint.currency.url
    }

    var httpMethod: HttpMethod {
        .get
    }

    var dto: Dto?
}
