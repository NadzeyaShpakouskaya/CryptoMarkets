//
//  CurrencyForMarketTableViewCell.swift
//  CryptoMarkets
//
//  Created by Nadzeya Shpakouskaya on 25/09/2021.
//

import UIKit

class CurrencyForMarketTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var trendImage: UIImageView!
    
    // MARK: - Public methods
    func configureCellFor(_ market: Market) {
        if let text = market.symbol{
            let currencies = text.split(separator: "-").joined(separator: " to ")
            currencyLabel.text = currencies
        } else {
            currencyLabel.text = market.symbol
        }
        
        volumeLabel.text = "via \(market.exchangeId ?? "n/a")"
        priceLabel.text =  "= \(formatPrice(market.price ?? 0))"
        
        switchArrow(trendImage, for: market.changeLastDay ?? 0)
    }
}
