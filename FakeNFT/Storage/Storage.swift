//
//  Storage.swift
//  FakeNFT
//
//  Created by Богдан Топорин on 19.12.2024.
//

import Foundation

extension UserDefaults {

    private enum Keys: String {
        case cart, cartLastChangeTime, currency, currencyLastChangeTime
    }

    @objc dynamic var cartLastChangeTime: Int {
        get {
            integer(forKey: Keys.cartLastChangeTime.rawValue)
        }
        set {
            setValue(newValue, forKey: Keys.cartLastChangeTime.rawValue)
        }
    }
    
    @objc dynamic var currencyLastChangeTime: Int {
        get {
            integer(forKey: Keys.currencyLastChangeTime.rawValue)
        }
        set {
            setValue(newValue, forKey: Keys.currencyLastChangeTime.rawValue)
        }
    }

    var cart: CartModel? {
        get {
            guard let data = data(forKey: Keys.cart.rawValue),
                  let record = try? JSONDecoder().decode(CartModel.self, from: data) else {
                return nil
            }
            return record
        }
        set {
            guard let data = try? JSONEncoder().encode(newValue) else {
                print("Невозможно сохранить результат")
                return
            }
            set(data, forKey: Keys.cart.rawValue)
        }
    }
    
    var currencies: [CurrencyModel]? {
            get {
                guard let data = data(forKey: Keys.currency.rawValue),
                      let record = try? JSONDecoder().decode([CurrencyModel].self, from: data) else {
                    return nil
                }
                return record
            }
            set {
                guard let data = try? JSONEncoder().encode(newValue) else {
                    print("Невозможно сохранить информацию об оплате")
                    return
                }
                set(data, forKey: Keys.currency.rawValue)
            }
        }

}
