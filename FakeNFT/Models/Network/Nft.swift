import Foundation

struct Nft: Decodable {
    let id: String
    let images: [URL]
    let name: String
    let price: Float
    let rating: Int
    let author: String
    let createdAt: String
    let description: String
}

typealias Nfts = [Nft]

