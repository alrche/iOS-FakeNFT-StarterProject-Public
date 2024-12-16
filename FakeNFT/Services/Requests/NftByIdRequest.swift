import Foundation

struct NFTRequest: NetworkRequest {
    let id: String
    var endpoint: URL? {
        Endpoint.nftById(id: self.id).url
    }
    var dto: Dto?
}
