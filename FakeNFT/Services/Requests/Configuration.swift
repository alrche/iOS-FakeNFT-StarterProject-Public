//
//  Configuration.swift
//  FakeNFT
//
//  Created by Aliaksandr Charnyshou on 14.12.2024.
//

import Foundation

enum Endpoint {
<<<<<<< HEAD
    case cart
    case profile
    case nftById(id: String)
    case currency
    case payment(id: String)
    
=======
    case profile
    case nftById(id: String)

>>>>>>> 25a356f95efa63357417625bf6d29c0fdb6d2da9
    static let baseURL = URL(string: RequestConstants.baseURL)!

    var path: String {
        switch self {
        case .profile: return "api/v1/profile/1"
<<<<<<< HEAD
        case .cart: return "api/v1/orders/1"
        case .nftById(let id): return "api/v1/nft/\(id)"
        case .currency: return "api/v1/currencies"
        case .payment(let id): return "/api/v1/orders/1/payment/\(id)"
=======
        case .nftById(let id): return "api/v1/nft/\(id)"
>>>>>>> 25a356f95efa63357417625bf6d29c0fdb6d2da9
        }
    }
    
    var url: URL? {
        switch self {
<<<<<<< HEAD
        case .cart: return URL(string: Endpoint.cart.path, relativeTo: Endpoint.baseURL)
        case .profile: return URL(string: Endpoint.profile.path, relativeTo: Endpoint.baseURL)
        case .nftById(let id): return URL(string: Endpoint.nftById(id: id).path,
                                          relativeTo: Endpoint.baseURL)
        case .currency: return URL(string: Endpoint.currency.path, relativeTo: Endpoint.baseURL)
        case .payment(let id): return URL(string: Endpoint.payment(id: id).path, relativeTo: Endpoint.baseURL)
=======
        case .profile: return URL(string: Endpoint.profile.path, relativeTo: Endpoint.baseURL)
        case .nftById(let id): return URL(string: Endpoint.nftById(id: id).path,
                                          relativeTo: Endpoint.baseURL)
>>>>>>> 25a356f95efa63357417625bf6d29c0fdb6d2da9
        }
    }
}
