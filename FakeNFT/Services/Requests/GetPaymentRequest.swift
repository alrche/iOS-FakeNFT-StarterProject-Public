//
//  PaymentRequest.swift
//  GetPaymentResponse.swift
//  FakeNFT
//
//  Created by Doroteya Galbacheva on 14.01.2025.
//  Created by Богдан Топорин on 27.12.2024.
//

import Foundation

struct GetPaymentRequest: NetworkRequest {
    let id: String
    var endpoint: URL? {
        Endpoint.payment(id: self.id).url
    }
    var dto: (any Dto)?
}

struct GetPaymentRequest: NetworkRequest {
    let id: String
    var endpoint: URL? {
        Endpoint.payment(id: self.id).url
    }
    var dto: Dto?
}
