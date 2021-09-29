//
//  Exchange.swift
//  CryptoMarkets
//
//  Created by Nadzeya Shpakouskaya on 24/09/2021.
//

struct Exchange: Codable {
    let exchangeId: String
    let name: String
    let website: String
    let volumeLastDay: Double
    
    enum CodingKeys: String, CodingKey {
        case exchangeId = "exchange_id"
        case name = "name"
        case website = "website"
        case volumeLastDay = "volume_24h"
    }
}

struct ExchangeDescription: Codable {
    let exchange: Exchange
}

struct AllExchangesDescription: Codable {
    let exchanges: [Exchange]
}
