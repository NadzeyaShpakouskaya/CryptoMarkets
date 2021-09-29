//
//  Extension+UIViewController.swift
//  CryptoMarkets
//
//  Created by Nadzeya Shpakouskaya on 29/09/2021.
//

import UIKit

extension UIViewController {
    func showAlert(with title: String, and text:String) {
        let alert = UIAlertController(
            title: title,
            message: text,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
