//
//  Exchange.swift
//  CryptoMarkets
//
//  Created by Nadzeya Shpakouskaya on 24/09/2021.
//

struct Exchange: Codable {
    let exchangeId: String?
    let name: String?
    let website: String?
    let volumeLastDay: Double?
    
    // for Alamofire parsing from JSON data
    init(data: [String: Any]) {
        self.exchangeId = data["exchange_id"] as? String
        self.name = data["name"] as? String
        self.website = data["website"] as? String
        self.volumeLastDay = data["volume_24h"] as? Double
    }
    
    static func transformToExchanges(data: Any) -> [Exchange] {
        guard let data = data as? [String: Any],
              let exchangesData = data["exchanges"] as? [[String:Any]] else { return [] }
        return exchangesData.compactMap { Exchange(data: $0) }
    }
    
    // for default NetworkManager
    enum CodingKeys: String, CodingKey {
        case exchangeId = "exchange_id"
        case name
        case website
        case volumeLastDay = "volume_24h"
    }
}

struct AllExchangesDescription: Codable {
    let exchanges: [Exchange]
    
//    static func transformToExchangesFrom(data: Any) -> [Exchange] {
//        guard let data = data as? [String: Any],
//              let exchangesData = data["exchanges"] else { return [] }
//        
//        let exchanges = Exchange.transformToExchanges(data: exchangesData)
//        return exchanges
//    }
}
