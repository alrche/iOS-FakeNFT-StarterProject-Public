//
//  PaymentResponse.swift
//  FakeNFT
//
//  Created by Богдан Топорин on 27.12.2024.
//

import Foundation

struct PaymentResponse: Decodable {
    let success: Bool
    let orderId: String
    let id: String
}
