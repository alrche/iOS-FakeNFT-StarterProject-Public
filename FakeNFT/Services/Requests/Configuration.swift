//
//  Configuration.swift
//  FakeNFT
//
//  Created by Aliaksandr Charnyshou on 14.12.2024.
//

import Foundation

enum Endpoint {
    case profile
    case nftById(id: String)

    static let baseURL = URL(string: RequestConstants.baseURL)!

    var path: String {
        switch self {
        case .profile: return "api/v1/profile/1"
        case .nftById(let id): return "api/v1/nft/\(id)"
        }
    }
    
    var url: URL? {
        switch self {
        case .profile: return URL(string: Endpoint.profile.path, relativeTo: Endpoint.baseURL)
        case .nftById(let id): return URL(string: Endpoint.nftById(id: id).path,
                                          relativeTo: Endpoint.baseURL)
        }
    }
}
