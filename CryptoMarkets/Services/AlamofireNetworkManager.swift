//
//  AlamofireNetworkManager.swift
//  CryptoMarkets
//
//  Created by Nadzeya Shpakouskaya on 29/09/2021.
//

import Foundation
import Alamofire

class AlamofireNetworkManager {
    
    //Create Singleton
    static let shared = AlamofireNetworkManager()
    private init() {}
    
    func fetchExchanges(url: String, completion: @escaping (Result<[Exchange], Error>) -> Void) {
        AF.request(url).validate().responseJSON { response in
            switch response.result {
            case .success(let data):
                print(data)
                
                let exchanges = AllExchangesDescription.transformToExchangesFrom(data: data)
                DispatchQueue.main.async {
                    completion(.success(exchanges))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // for practice use Alamofire Decodable Response
    func fetchAllExchangesDecodable(url: String, completion: @escaping (Result<[Exchange], Error>) -> Void) {
        let url = Constants.basicURL + Route.exchangesAll.rawValue
        AF.request(url).validate().responseDecodable(of: AllExchangesDescription.self) { response in
            switch response.result {
            case .success(let data):
                DispatchQueue.main.async {
                    completion(.success(data.exchanges))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
    func fetchMarkets(url: String, completion: @escaping (Result<[Market], Error>) -> Void) {
        AF.request(url).validate().responseJSON { response in
            switch response.result {
            case .success(let data):
                let markets = AllMarketsDescription.transformToMarkets(data: data)
                DispatchQueue.main.async {
                completion(.success(markets))
                }
            case .failure(let error):
                completion(.failure(error))
            
            }
        }
    }
   
    func fetchCurrencies(url: String, completion: @escaping (Result<[Currency], Error>) -> ()) {
        AF.request(url).validate().responseJSON { response in
            switch response.result {
            case .success(let data):
                let currencies = AllCurrenciesDescription.transformToCurrencies(data: data)
                DispatchQueue.main.async {
                completion(.success(currencies))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
