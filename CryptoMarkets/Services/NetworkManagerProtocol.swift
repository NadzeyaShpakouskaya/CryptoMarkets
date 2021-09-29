//
//  NetworkManagerProtocol.swift
//  CryptoMarkets
//
//  Created by Nadzeya Shpakouskaya on 29/09/2021.
//

import Foundation

/// Defines methods that should be implemented for Network Manager
protocol NetworkManagerProtocol {

    func fetchExchanges(url: String, completion: @escaping (Result<[Exchange], Error>) -> Void)
    func fetchMarkets(url: String, completion: @escaping (Result<[Market], Error>) -> Void)
    func fetchCurrencies(url: String, completion: @escaping (Result<[Currency], Error>) -> Void)
}
