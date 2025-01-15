//
//  PaymentResponse.swift
//  FakeNFT
//
//  Created by Doroteya Galbacheva on 14.01.2025.
//

import Foundation

struct PaymentResponse: Codable {
    let success: Bool
    let orderId: String
    let id: String
}
