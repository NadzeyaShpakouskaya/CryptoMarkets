//
//  MarketsByCurrencyViewController.swift
//  CryptoMarkets
//
//  Created by Nadzeya Shpakouskaya on 25/09/2021.
//

import UIKit

class MarketsByCurrencyViewController: UITableViewController {
    var currency: Currency!
    
    private var markets: [Market] = []
    private let dataManager = NetworkManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        title = currency.name
        
        dataManager.fetchMarketsForCurrencyBy(id: currency.asset_id) { result in
            switch result {
    
            case .success(let markets):
                self.markets = markets
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return markets.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "marketCurrencyCell", for: indexPath) as! CurrencyForMarketTableViewCell

        let market = markets[indexPath.row]
        cell.configureCellFor(market)
        // Configure the cell...

        return cell
    }

}
