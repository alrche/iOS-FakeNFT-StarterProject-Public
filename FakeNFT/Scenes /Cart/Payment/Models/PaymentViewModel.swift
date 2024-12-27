//
//  PaymentViewModel.swift
//  FakeNFT
//
//  Created by Богдан Топорин on 27.12.2024.
//

import Foundation

final class PaymentViewModel {
    
    // MARK: - Public properties

    private(set) var currenciesList: [CurrencyModel]? {
        didSet {
            onCurrencyListLoaded?()
        }
    }
    var onPaymentSuccess: (() -> Void)?
    var onPaymentError: ((String) -> Void)?
    var onCurrencyListLoaded: (() -> Void)?
    var onCurrencyListLoadError: ((String) -> Void)?
    
    // MARK: - Private properties

    private let cartService = CartService()
    private var userDefaults: UserDefaults {
        UserDefaults.standard
    }

    // MARK: - Public methods

    func viewDidLoad() {
        fetchCurrencies()
    }

    // MARK: - Public methods to trigger payment

        func initiatePayment(for id: String) {
            processPayment(id: id) 
        }
    
    // MARK: - Private methods
    private func processPayment(id: String) {
            CartService.fetchPayment(id: id) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let payment):
                    if payment.success {
                        self.onPaymentSuccess?()
                    } else {
                        self.onPaymentError?("Payment failed: Invalid response.")
                    }
                case .failure(let error):
                    self.onPaymentError?("Payment failed: \(error.localizedDescription)")
                }
            }
        }
    
    private func fetchCurrencies() {
        CartService.fetchCurrencyList { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let currencies):
                self.currenciesList = currencies
            case .failure(let error):
                self.onCurrencyListLoadError?("Failed to fetch currencies: \(error.localizedDescription)")
            }
        }
    }
}
