//
//  Currency.swift
//  CryptoMarkets
//
//  Created by Nadzeya Shpakouskaya on 24/09/2021.
//

struct Currency: Codable {
    
    let asset_id: String
    let name: String
    let price: Double
    let volume_24h: Double
    let change_1h: Double
    let change_24h: Double
    let change_7d: Double
    
}

struct AllCurrenciesDescription: Codable {
    let assets: [Currency]
}

struct CurrencyDescription: Codable {
    let asset: Currency
}
