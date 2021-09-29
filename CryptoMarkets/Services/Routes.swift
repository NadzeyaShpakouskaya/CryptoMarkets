//
//  Routes.swift
//  CryptoMarkets
//
//  Created by Nadzeya Shpakouskaya on 29/09/2021.
//

import Foundation


enum Route: String {
    case exchangesAll = "exchanges"
    case marketsAll = "markets"
    case currenciesAll = "assets"
}


struct Constants {
    static let basicURL = "https://www.cryptingup.com/api/"
}
