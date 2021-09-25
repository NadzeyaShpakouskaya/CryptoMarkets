//
//  Exchange.swift
//  CryptoMarkets
//
//  Created by Nadzeya Shpakouskaya on 24/09/2021.
//

struct Exchange: Codable {
    
    let exchange_id: String
    let name: String
    let website: String
    let volume_24h: Double
    
}

struct ExchangeDescription: Codable {
    let exchange: Exchange
}

struct AllExchangesDescription: Codable {
    let exchanges: [Exchange]
}
