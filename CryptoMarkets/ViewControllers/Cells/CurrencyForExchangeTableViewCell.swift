//
//  CurrencyForExchangeTableViewCell.swift
//  CryptoMarkets
//
//  Created by Nadzeya Shpakouskaya on 25/09/2021.
//

import UIKit

class CurrencyForExchangeTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var assetLabel: UILabel!
    
    @IBOutlet weak var tradeImage: UIImageView!
    
 
    func configureCellFor(for market: Market) {
        nameLabel.text = market.base_asset
        assetLabel.text = "to \(market.quote_asset)"
        priceLabel.text = formatPrice(market.price_unconverted)
        
        switchArrow(tradeImage, for: market.change_24h)

    }
}
