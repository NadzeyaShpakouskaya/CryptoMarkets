//
//  NetworkManager.swift
//  CryptoMarkets
//
//  Created by Nadzeya Shpakouskaya on 25/09/2021.
//

import UIKit

class NetworkManager: NetworkManagerProtocol {
    
    //Create Singleton
    static let shared = NetworkManager()
    private init() {}
    
    //MARK: - Public methods
    func fetchExchanges(url: String, completion: @escaping (Result<[Exchange], Error>) -> Void) {
        fetchData(
            dataType: AllExchangesDescription.self,
            from: url,
            convertFromSnakeCase: false
        ) { result in
            switch result {
            case .success(let description):
                DispatchQueue.main.async {
                    completion(.success(description.exchanges))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func fetchMarkets(url: String, completion: @escaping (Result<[Market], Error>) -> Void) {
        let url = Constants.basicURL + Route.marketsAll.rawValue
        fetchData(
            dataType: AllMarketsDescription.self,
            from: url,
            convertFromSnakeCase: false
        ) { result in
            switch result {
            case .success(let description):
                DispatchQueue.main.async {
                    completion(.success(description.markets))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    
    func fetchCurrencies(url: String, completion: @escaping (Result<[Currency], Error>) -> Void) {
        fetchData(
            dataType: AllCurrenciesDescription.self,
            from: url,
            convertFromSnakeCase: false
        ) { result in
            switch result {
            case .success(let description):
                DispatchQueue.main.async {
                    completion(.success(description.assets))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    //MARK: - Privates methods
    
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
    
}
enum NetworkError: Error {
    case invalidUrl
    case noData
    case decodingError
    case encodingError
}
