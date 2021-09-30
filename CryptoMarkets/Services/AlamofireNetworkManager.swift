//
//  AlamofireNetworkManager.swift
//  CryptoMarkets
//
//  Created by Nadzeya Shpakouskaya on 29/09/2021.
//

import Foundation
import Alamofire

class AlamofireNetworkManager: NetworkManagerProtocol {
    
    //Create Singleton
    static let shared = AlamofireNetworkManager()
    private init() {}
    
    //MARK: - Network Manager
    func fetchExchanges(url: String, completion: @escaping (Result<[Exchange], Error>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    let exchanges = Exchange.transformToExchanges(data: data)
                    completion(.success(exchanges))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    // for practice use Alamofire Decodable Response
    func fetchAllExchangesDecodable(completion: @escaping (Result<[Exchange], Error>) -> Void) {
        let url = Constants.basicURL + Route.exchangesAll.rawValue
        AF.request(url)
            .validate()
            .responseDecodable(of: AllExchangesDescription.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data.exchanges))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        
    }
    
    func fetchMarkets(url: String, completion: @escaping (Result<[Market], Error>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    let markets = AllMarketsDescription.transformToMarkets(data: data)
                    completion(.success(markets))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchCurrencies(url: String, completion: @escaping (Result<[Currency], Error>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    let currencies = AllCurrenciesDescription.transformToCurrencies(data: data)
                    completion(.success(currencies))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
}
