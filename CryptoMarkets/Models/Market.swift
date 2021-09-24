//
//  Market.swift
//  CryptoMarkets
//
//  Created by Nadzeya Shpakouskaya on 24/09/2021.
//

struct Market: Codable {
    
    let exchangeId: String
    let symbol: String
    let baseAsset: String
    let price: Double
    let change24h: Double
    let volume24h: Double
    
}

struct MarketsDescription: Codable {
    let markets: [Market]
}
