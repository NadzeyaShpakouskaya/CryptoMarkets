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
    
    // Generic method to fetch Any data
    private func fetchData<T:Codable>(dataType: T.Type, from url: String, convertFromSnakeCase: Bool = true, completion: @escaping (Result<T, NetworkError>) -> Void ) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidUrl))
            print(NetworkError.invalidUrl)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "unknown data error")
                return
            }
            do {
                let decoder = JSONDecoder()
                if convertFromSnakeCase {
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                }
                let type = try decoder.decode(T.self, from: data)
                completion(.success(type))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func fetchAllExchanges(completion: @escaping (Result<[Exchange], Error>) -> Void) {
        let url = Constants.basicURL + Route.exchangesAll.rawValue
        fetchData(dataType: AllExchangesDescription.self, from: url, convertFromSnakeCase: false) { result in
            switch result {
            case .success(let description):
                DispatchQueue.main.async {
                    completion(.success(description.exchanges))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    func fetchExchange(by id: String, completion: @escaping (Result<Exchange, Error>) -> Void) {
        let url = Constants.basicURL + Route.exchangesAll.rawValue + "/" + id
        fetchData(dataType: ExchangeDescription.self, from: url, convertFromSnakeCase: false) { result in
            switch result {
            case .success(let description):
                DispatchQueue.main.async {
                    completion(.success(description.exchange))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchAllMarkets(completion: @escaping (Result<[Market], Error>) -> Void) {
        let url = Constants.basicURL + Route.marketsAll.rawValue
        fetchData(dataType: AllMarketsDescription.self, from: url, convertFromSnakeCase: false) { result in
            switch result {
            case .success(let description):
                DispatchQueue.main.async {
                    completion(.success(description.markets))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchMarketBy(id: String, completion: @escaping (Result<[Market], Error>) -> Void) {
        let url = Constants.basicURL + Route.exchangesAll.rawValue + "/" + id + "/markets"
        fetchData(dataType: AllMarketsDescription.self, from: url, convertFromSnakeCase: false) { result in
            switch result {
            case .success(let description):
                DispatchQueue.main.async {
                    completion(.success(description.markets))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    func fetchAllCurrencies(completion: @escaping (Result<[Currency], Error>) -> ()) {
        let url = Constants.basicURL + Route.currenciesAll.rawValue
        
        fetchData(dataType: AllCurrenciesDescription.self, from: url, convertFromSnakeCase: false) { result in
            switch result {
            case .success(let description):
                DispatchQueue.main.async {
                    completion(.success(description.assets))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchMarketsForCurrencyBy(id: String, completion: @escaping (Result<[Market], Error>) -> ()) {
        let url = Constants.basicURL + Route.currenciesAll.rawValue + "/" + id + "/markets"
        
        fetchData(dataType: AllMarketsDescription.self, from: url, convertFromSnakeCase: false) { result in
            switch result {
            case .success(let description):
                DispatchQueue.main.async {
                    completion(.success(description.markets))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
enum NetworkError: Error {
    case invalidUrl
    case noData
    case decodingError
    case encodingError
}
