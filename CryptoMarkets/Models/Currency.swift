//
//  Currency.swift
//  CryptoMarkets
//
//  Created by Nadzeya Shpakouskaya on 24/09/2021.
//

struct Currency: Codable {
    let assetId: String
    let name: String
    let price: Double
    let volumeLastDay: Double
    let changeLastHour: Double
    let changeLastDay: Double
    let changeLastWeek: Double
    
    enum CodingKeys: String, CodingKey {
        case assetId = "asset_id"
        case name =  "name"
        case price = "price"
        case volumeLastDay = "volume_24h"
        case changeLastHour = "change_1h"
        case changeLastDay = "change_24h"
        case changeLastWeek = "change_7d"
    }
}

struct AllCurrenciesDescription: Codable {
    let assets: [Currency]
}

struct CurrencyDescription: Codable {
    let asset: Currency
}
