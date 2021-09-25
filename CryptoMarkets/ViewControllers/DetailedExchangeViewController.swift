//
//  DetailedExchangeViewController.swift
//  CryptoMarkets
//
//  Created by Nadzeya Shpakouskaya on 25/09/2021.
//

import UIKit

class DetailedExchangeViewController: UITableViewController {
    var exchange: Exchange!
    
    private var markets: [Market] = []
    private let dataManager = NetworkManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        title = exchange.name
        
        fetchData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? 2 : markets.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath)
            
            var content = cell.defaultContentConfiguration()
            switch indexPath.row {
            case 0:
                let value = String(format: "%.2f", exchange.volume_24h)
                content.text = "Volume: \(value)"
            default:
                content.text = exchange.website
            }
            content.textProperties.font = UIFont(name: "Geeza Pro", size: 16) ?? .systemFont(ofSize: 16)
            cell.contentConfiguration = content
    
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCell", for: indexPath) as! CurrencyForExchangeTableViewCell
            let market = markets[indexPath.row]
            cell.configureCellFor(for: market)
            return cell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section != 0 ? "Currencies" : nil
    }
    
    private func fetchData() {
        dataManager.fetchMarketBy(id: exchange.exchange_id) { result in
            switch result {
            case .success(let markets):
                self.markets = markets
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                print(markets)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}
