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
    let quoteAsset: String
    let price: Double
    let changeLastDay: Double
    let volumeLastDay: Double
    
    enum CodingKeys: String, CodingKey {
        case exchangeId =  "exchange_id"
        case symbol = "symbol"
        case baseAsset =  "base_asset"
        case quoteAsset = "quote_asset"
        case price = "price_unconverted"
        case changeLastDay = "change_24h"
        case volumeLastDay = "volume_24h"
    }
    
}

struct AllMarketsDescription: Codable {
    let markets: [Market]
}
