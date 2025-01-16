//
//  OrderAndPaymentService.swift
//  FakeNFT
//
//  Created by Doroteya Galbacheva on 14.01.2025.
//

import Foundation

typealias OrderCompletion = (Result<CartModel, Error>) -> Void
typealias CurrencyListCompletion = (Result<[CurrencyModel], Error>) -> Void
typealias PaymentConfirmationRequest = (Result<PaymentResponse, Error>) -> Void

protocol OrderService {
    func loadOrder(completion: @escaping OrderCompletion)
    func loadCurrencyList(completion: @escaping CurrencyListCompletion)
    func updateOrder(nftsIds: [String], completion: @escaping OrderCompletion)
    func loadPayment(id: String, completion: @escaping PaymentConfirmationRequest)
}

final class OrderServiceImpl: OrderService {
    
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func loadOrder(completion: @escaping OrderCompletion) {
        networkClient.send(request: GetCartRequest(), type: CartModel.self) { result in
            switch result {
            case .success(let order):
                completion(.success(order))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func loadCurrencyList(completion: @escaping CurrencyListCompletion) {
        networkClient.send(request: GetCurrenciesRequest(), type: [CurrencyModel].self) { result in
            switch result {
            case .success(let currencies):
                print("Received currencies: \(currencies)")
                completion(.success(currencies))
            case .failure(let error):
                print("Error loading currency list: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    func updateOrder(nftsIds: [String], completion: @escaping OrderCompletion) {
        let newOrderModel = NewOrderModel(nfts: nftsIds)
        let request = EditOrderRequest(newOrder: newOrderModel)
        
        networkClient.send(request: request, type: CartModel.self) { result in
            switch result {
            case .success(let order):
                completion(.success(order))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func loadPayment(id: String, completion: @escaping PaymentConfirmationRequest) {
        networkClient.send(request: GetPaymentRequest(id: id), type: PaymentResponse.self) { result in
            switch result {
            case .success(let payment):
                print("Received currencies: \(payment)")
                completion(.success(payment))
            case .failure(let error):
                print("Error loading currency list: \(error)")
                completion(.failure(error))
            }
        }
    }
}

