//
//  Market.swift
//  CryptoMarkets
//
//  Created by Nadzeya Shpakouskaya on 24/09/2021.
//

struct Market: Codable {
    
    let exchangeId: String?
    let symbol: String?
    let baseAsset: String?
    let quoteAsset: String?
    let price: Double?
    let changeLastDay: Double?
    let volumeLastDay: Double?
    
    // for Alamofire parsing from JSON
    init(data: [String: Any]) {
        self.exchangeId = data["exchange_id"] as? String
        self.symbol = data["symbol"] as? String
        self.baseAsset = data["base_asset"] as? String
        self.quoteAsset = data["quote_asset"] as? String
        self.price = data["price_unconverted"] as? Double
        self.changeLastDay = data["change_24h"] as? Double
        self.volumeLastDay = data["volume_24h"] as? Double
    }
    
    static func transformToMarkets(data: Any) -> [Market] {
        guard let data = data as? [[String:Any]] else { return [] }
        return data.compactMap { Market(data: $0) }
    }
    
    // for default NetworkManager
    enum CodingKeys: String, CodingKey {
        case exchangeId =  "exchange_id"
        case symbol
        case baseAsset =  "base_asset"
        case quoteAsset = "quote_asset"
        case price = "price_unconverted"
        case changeLastDay = "change_24h"
        case volumeLastDay = "volume_24h"
    }
    
}

struct AllMarketsDescription: Codable {
    let markets: [Market]
    
    static func transformToMarkets(data: Any) -> [Market] {
        guard let data = data as? [String: Any],
              let marketsData = data["markets"] else { return [] }
        
        let markets = Market.transformToMarkets(data: marketsData)
        return markets
    }
}
