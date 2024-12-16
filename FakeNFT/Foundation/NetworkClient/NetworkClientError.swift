//
//  NetworkClientError.swift
//  FakeNFT
//
//  Created by Aliaksandr Charnyshou on 15.12.2024.
//

import Foundation

// MARK: - NetworkClientError
enum NetworkClientError: Error {
    case httpStatusCode(Int)
    case urlRequestError(Error)
    case urlSessionError
    case parsingError
}

// MARK: - LocalizedError
extension NetworkClientError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .httpStatusCode(let code):
            switch code {
            case 429: return L.Network.Error.httpStatusCode429
            case 400..<500:
                return L.Network.Error.httpStatusCode4xx
            case 500..<600:
                return L.Network.Error.httpStatusCode5xx
            default: return L.Network.Error.httpStatusCode
            }
        case .urlRequestError:
            return L.Network.Error.urlRequestError
        case .urlSessionError:
            return L.Network.Error.urlSessionError
        case .parsingError:
            return L.Network.Error.parsingError
        }
    }
}
