//
//  CurrencyForExchangeTableViewCell.swift
//  CryptoMarkets
//
//  Created by Nadzeya Shpakouskaya on 25/09/2021.
//

import UIKit

class CurrencyForExchangeTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var assetLabel: UILabel!
    
    @IBOutlet weak var tradeImage: UIImageView!
    
    // MARK: - Public methods
    func configureCellFor(for market: Market) {
        nameLabel.text = market.baseAsset
        assetLabel.text = market.quoteAsset
        priceLabel.text = "= \(formatPrice(market.price ?? 0))"
        
        switchArrow(tradeImage, for: market.changeLastDay ?? 0)

    }
}
