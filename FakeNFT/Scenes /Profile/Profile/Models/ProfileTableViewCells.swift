//
//  ProfileTableViewCells.swift
//  FakeNFT
//
//  Created by Aliaksandr Charnyshou on 14.12.2024.
//

import Foundation

// MARK: - ProfileTableViewCells
enum ProfileTableViewCells {
    case myNFT(Int)
    case favouriteNFT(Int)
    case about

    var name: String {
        switch self {
        case .myNFT(let number): return L.Profile.myNFT(number)
        case .favouriteNFT(let number): return L.Profile.favouriteNFT(number)
        case .about: return L.Profile.about
        }
    }
}
