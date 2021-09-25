//
//  CurrencyForMarketTableViewCell.swift
//  CryptoMarkets
//
//  Created by Nadzeya Shpakouskaya on 25/09/2021.
//

import UIKit

class CurrencyForMarketTableViewCell: UITableViewCell {

    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var trendImage: UIImageView!
    
    func configureCellFor(_ market: Market) {
        currencyLabel.text = market.symbol
        volumeLabel.text = "via \(market.exchange_id)"
        priceLabel.text =  formatPrice(market.price_unconverted)
        switchArrow(trendImage, for: market.change_24h)
    }
}
