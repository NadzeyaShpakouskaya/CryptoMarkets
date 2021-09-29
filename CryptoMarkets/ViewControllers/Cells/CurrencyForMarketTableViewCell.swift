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
        currencyLabel.text = market.symbol
        volumeLabel.text = "via \(market.exchangeId)"
        priceLabel.text =  formatPrice(market.price)
        
        switchArrow(trendImage, for: market.changeLastDay)
    }
}
