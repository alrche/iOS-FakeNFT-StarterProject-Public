//
//  ProfileItem.swift
//  FakeNFT
//
//  Created by Aliaksandr Charnyshou on 14.12.2024.
//

import Foundation

struct ProfileItem {
    var categoryName: String
    var count: Int?

    init(
        categoryName: String,
        count: Int? = nil
    ) {
        self.categoryName = categoryName
        self.count = count
    }
}
