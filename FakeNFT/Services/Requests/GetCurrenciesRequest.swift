//
//  CurrencyListRequest.swift
//  FakeNFT
//
//  Created by Doroteya Galbacheva on 14.01.2025.
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

