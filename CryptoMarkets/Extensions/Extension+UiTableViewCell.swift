//
//  Extension+UiTableViewCell.swift
//  CryptoMarkets
//
//  Created by Nadzeya Shpakouskaya on 26/09/2021.
//

import UIKit

extension UITableViewCell {
    // Switch between green Up Arrow and red Down Arrow depends on providing value
    func switchArrow(_ image: UIImageView, for value: Double) {
        if value <= 0 {
            image.image = UIImage(systemName: "arrow.down")
            image.tintColor = .systemRed
        } else {
            image.image = UIImage(systemName: "arrow.up")
            image.tintColor = .systemGreen
        }
    }
    
    // format Double to 0.00001 if less 10, and 0.001 if more 10
    func formatPrice(_ price: Double) -> String {
        price <= 10 ? String(format: "%.5f", price): String(format: "%.3f", price)
    }
}
