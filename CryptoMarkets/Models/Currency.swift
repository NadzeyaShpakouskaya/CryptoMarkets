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
    let volume24h: Double
    let change1h: Double
    let change24h: Double
    let change7d: Double
    
}

struct CurrenciesDescription: Codable {
    let currencies: [Currency]
}
