//
//  CurencyTableViewCell.swift
//  CryptoMarkets
//
//  Created by Nadzeya Shpakouskaya on 25/09/2021.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {

    
    @IBOutlet weak var shortNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var last1hourValueLabel: UILabel!
    @IBOutlet weak var last24hoursValueLabel: UILabel!


    @IBOutlet weak var last24HoursImage: UIImageView!
    @IBOutlet weak var last1HourImage: UIImageView!
    
    func configureCellFor(_ currency: Currency) {
        shortNameLabel.text = currency.asset_id
        nameLabel.text = currency.name == "" ? currency.asset_id : currency.name
        priceLabel.text = formatPrice(currency.price)
        switchArrow(last1HourImage, for: currency.change_1h)
        switchArrow(last24HoursImage, for: currency.change_24h)

    }
    
   
}

extension UITableViewCell {
    func switchArrow(_ image: UIImageView, for value: Double) {
        if value <= 0 {
            image.image = UIImage(systemName: "arrow.down")
            image.tintColor = .systemRed
        } else {
            image.image = UIImage(systemName: "arrow.up")
            image.tintColor = .systemGreen
        }
    }
    
    func formatPrice(_ price: Double) -> String {
        price <= 1000 ? String(format: "%.5f", price): String(format: "%.2f", price)
    }
}
