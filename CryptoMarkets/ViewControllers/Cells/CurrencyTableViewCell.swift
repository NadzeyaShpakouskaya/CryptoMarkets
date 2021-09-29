//
//  CurencyTableViewCell.swift
//  CryptoMarkets
//
//  Created by Nadzeya Shpakouskaya on 25/09/2021.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var shortNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var last1hourValueLabel: UILabel!
    @IBOutlet weak var last24hoursValueLabel: UILabel!

    @IBOutlet weak var last24HoursImage: UIImageView!
    @IBOutlet weak var last1HourImage: UIImageView!
    
    // MARK: - Public methods
    func configureCellFor(_ currency: Currency) {
        shortNameLabel.text = currency.assetId
        nameLabel.text = currency.name == "" ? currency.assetId : currency.name
        priceLabel.text = formatPrice(currency.price)
        
        switchArrow(last1HourImage, for: currency.changeLastHour)
        switchArrow(last24HoursImage, for: currency.changeLastDay)

    }
    
   
}

