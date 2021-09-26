//
//  NetworkManager.swift
//  CryptoMarkets
//
//  Created by Nadzeya Shpakouskaya on 25/09/2021.
//

import UIKit

class NetworkManager {
    //Create Singleton
    static let shared = NetworkManager()
    private init() {}
    
    func fetchAllExchanges(completion: @escaping (Result<[Exchange], Error>) -> ()) {
        guard let url = URL(string: Constants.basicURL + Route.exchangesAll.rawValue) else {
            print("URL was not generated.")
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "unknown error")
                return
            }
            do {
                let decoder = JSONDecoder()
                let info = try decoder.decode(AllExchangesDescription.self, from: data)
                completion(.success(info.exchanges))
            } catch let error {
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }.resume()
        
    }
    
    func fetchExchangeBy(id: String, completion: @escaping (Result<Exchange, Error>) -> ()) {
        guard let url = URL(string: Constants.basicURL + Route.exchangesAll.rawValue + "/" + id) else {
            print("URL was not generated.")
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "unknown error")
                return
            }
            do {
                let decoder = JSONDecoder()
                let exchange = try decoder.decode(ExchangeDescription.self, from: data)
                completion(.success(exchange.exchange))
            } catch let error {
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func fetchAllMarkets(completion: @escaping (Result<[Market], Error>) -> ()) {
        guard let url = URL(string: Constants.basicURL + Route.marketsAll.rawValue) else {
            print("URL was not generated.")
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "unknown error")
                return
            }
            do {
                let decoder = JSONDecoder()
                let info = try decoder.decode(AllMarketsDescription.self, from: data)
                completion(.success(info.markets))
            } catch let error {
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func fetchMarketBy(id: String, completion: @escaping (Result<[Market], Error>) -> ()) {
        guard let url = URL(
            string: Constants.basicURL + Route.exchangesAll.rawValue + "/" + id + "/markets"
        ) else {
            print("URL was not generated.")
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "unknown error")
                return
            }
            do {
                let decoder = JSONDecoder()
                let info = try decoder.decode(AllMarketsDescription.self, from: data)
                completion(.success(info.markets))
            } catch let error {
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func fetchAllCurrencies(completion: @escaping (Result<[Currency], Error>) -> ()) {
        guard let url = URL(string: Constants.basicURL + Route.currenciesAll.rawValue) else {
            print("URL was not generated.")
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "unknown error")
                return
            }
            do {
                let decoder = JSONDecoder()
                let info = try decoder.decode(AllCurrenciesDescription.self, from: data)
                completion(.success(info.assets))
            } catch let error {
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func fetchMarketsForCurrencyBy(id: String, completion: @escaping (Result<[Market], Error>) -> ()) {
        guard let url = URL(string: Constants.basicURL + Route.currenciesAll.rawValue + "/" + id + "/markets") else {
            print("URL was not generated.")
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "unknown error")
                return
            }
            do {
                let decoder = JSONDecoder()
                let info = try decoder.decode(AllMarketsDescription.self, from: data)
                completion(.success(info.markets))
            } catch let error {
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }.resume()
    }
}


enum Route: String {
    case exchangesAll = "exchanges"
    case marketsAll = "markets"
    case currenciesAll = "assets"
}

struct Constants {
    static var basicURL = "https://www.cryptingup.com/api/"
}
