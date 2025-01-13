//
//  CatalogRequest.swift
//  FakeNFT
//
//  Created by Doroteya Galbacheva on 22.12.2024.
//

import Foundation

struct CatalogRequest: NetworkRequest {
    
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/collections")
    }
    var dto: Dto?
}
