//
//  GetPaymentResponse.swift
//  FakeNFT
//
//  Created by Богдан Топорин on 27.12.2024.
//

import Foundation

struct GetPaymentRequest: NetworkRequest {
    let id: String
    var endpoint: URL? {
        Endpoint.payment(id: self.id).url
    }
    var dto: Dto?
}
