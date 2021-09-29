//
//  MarketsByCurrencyViewController.swift
//  CryptoMarkets
//
//  Created by Nadzeya Shpakouskaya on 25/09/2021.
//

import UIKit

class MarketsByCurrencyViewController: UITableViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Public properties
    var currency: Currency!
    
    // MARK: - Private properties
    private var markets: [Market] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = currency.name
        fetchMarketsForCurrency()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return markets.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "marketCurrencyCell", for: indexPath) as! CurrencyForMarketTableViewCell
        
        let market = markets[indexPath.row]
        cell.configureCellFor(market)
        
        return cell
    }
    
    // MARK: - Private methods
    private func fetchMarketsForCurrency() {
        NetworkManager.shared.fetchMarketsForCurrencyBy(id: currency.assetId) { result in
            switch result {
            case .success(let markets):
                self.markets = markets
                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
