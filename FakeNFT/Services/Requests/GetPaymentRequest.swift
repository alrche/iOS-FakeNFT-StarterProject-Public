//
//  PaymentRequest.swift
//  FakeNFT
//
//  Created by Doroteya Galbacheva on 14.01.2025.
//

import Foundation

struct GetPaymentRequest: NetworkRequest {
    let id: String
    var endpoint: URL? {
        Endpoint.payment(id: self.id).url
    }
    var dto: (any Dto)?
}

