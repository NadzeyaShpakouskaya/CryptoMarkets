//
//  Currency.swift
//  CryptoMarkets
//
//  Created by Nadzeya Shpakouskaya on 24/09/2021.
//

struct Currency: Codable {
    let assetId: String?
    let name: String?
    let price: Double?
    let volumeLastDay: Double?
    let changeLastHour: Double?
    let changeLastDay: Double?
    let changeLastWeek: Double?
    
    // for Alamofire parsing from JSON
    init(data: [String: Any]) {
        self.assetId = data["asset_id"] as? String
        self.name = data["name"] as? String
        self.price = data["price"] as? Double
        self.volumeLastDay = data["volume_24h"] as? Double
        self.changeLastHour = data["change_1h"] as? Double
        self.changeLastDay = data["change_24h"] as? Double
        self.changeLastWeek = data["change_7d"] as? Double
    }
    
    static func transformToCurrencies(data: Any) -> [Currency] {
        guard let data = data as? [[String:Any]] else { return [] }
        return data.compactMap { Currency(data: $0) }
    }
    
    // for default NetworkManager
    enum CodingKeys: String, CodingKey {
        case assetId = "asset_id"
        case name
        case price
        case volumeLastDay = "volume_24h"
        case changeLastHour = "change_1h"
        case changeLastDay = "change_24h"
        case changeLastWeek = "change_7d"
    }
}

struct AllCurrenciesDescription: Codable {
    let assets: [Currency]
    
    static func transformToCurrencies(data: Any) -> [Currency] {
        guard let data = data as? [String: Any],
              let currenciesData = data["assets"] else { return [] }
        let currencies = Currency.transformToCurrencies(data: currenciesData)
        return currencies
        
    }
}
