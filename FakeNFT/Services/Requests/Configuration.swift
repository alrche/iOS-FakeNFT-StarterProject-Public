//
//  Configuration.swift
//  FakeNFT
//
//  Created by Aliaksandr Charnyshou on 14.12.2024.
//

import Foundation

enum Endpoint {
    case cart
    case profile
    case nftById(id: String)
    case currency
    case payment(id: String)

    static let baseURL = URL(string: RequestConstants.baseURL)!

    var path: String {
        switch self {
        case .profile: return "api/v1/profile/1"
        case .cart: return "api/v1/orders/1"
        case .nftById(let id): return "api/v1/nft/\(id)"
        case .currency: return "api/v1/currencies"
        case .payment(let id): return "/api/v1/orders/1/payment/\(id)"
        }
    }

    var url: URL? {
        switch self {
        case .cart: return URL(string: Endpoint.cart.path, relativeTo: Endpoint.baseURL)
        case .profile: return URL(string: Endpoint.profile.path, relativeTo: Endpoint.baseURL)
        case .nftById(let id): return URL(string: Endpoint.nftById(id: id).path,
                                          relativeTo: Endpoint.baseURL)
        case .currency: return URL(string: Endpoint.currency.path, relativeTo: Endpoint.baseURL)
        case .payment(let id): return URL(string: Endpoint.payment(id: id).path, relativeTo: Endpoint.baseURL)
        }
    }
}
