//
//  Configuration.swift
//  FakeNFT
//
//  Created by Aliaksandr Charnyshou on 14.12.2024.
//

import Foundation

enum Endpoint {
    case profile

    static let baseURL = URL(string: RequestConstants.baseURL)!

    var path: String {
        switch self {
        case .profile: return "api/v1/profile/1"
        }
    }

    var url: URL? {
        switch self {
        case .profile: return URL(string: Endpoint.profile.path, relativeTo: Endpoint.baseURL)
        }
    }
}
