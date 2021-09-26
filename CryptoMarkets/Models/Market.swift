//
//  Market.swift
//  CryptoMarkets
//
//  Created by Nadzeya Shpakouskaya on 24/09/2021.
//

struct Market: Codable {
    
    let exchange_id: String
    let symbol: String
    let base_asset: String
    let quote_asset: String
    let price_unconverted: Double
    let change_24h: Double
    let volume_24h: Double
    
}

struct AllMarketsDescription: Codable {
    let markets: [Market]
}
