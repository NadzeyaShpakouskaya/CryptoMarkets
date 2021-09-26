//
//  DetailedExchangeViewController.swift
//  CryptoMarkets
//
//  Created by Nadzeya Shpakouskaya on 25/09/2021.
//

import UIKit

class DetailedExchangeViewController: UITableViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Public properties
    var exchange: Exchange!
    
    // MARK: - Private properties
    private var markets: [Market] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = exchange.name
        tableView.sectionHeaderHeight = 35
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
                content.text = "Trade Volume:"
                content.secondaryText = exchange.volume_24h.formatted(.number)
            default:
                content.text = "Website:"
                content.secondaryText = exchange.website
            }
            
            content.textProperties.font = UIFont(name: "Geeza Pro", size: 14) ??
                .systemFont(ofSize: 14)
            content.textProperties.color = .darkGray
            content.secondaryTextProperties.font = UIFont(name: "Geeza Pro Bold", size: 16) ??
                .systemFont(ofSize: 16)
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
        
        return section != 0 ? "Currencies" : "Information"
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UILabel()
        
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                          NSAttributedString.Key.font: UIFont(name: "Geeza Pro Bold", size: 18.0)!]
        let infoHeader = NSAttributedString(string:  "Information", attributes: attributes)
        let currenciesHeader = NSAttributedString(string: "Currencies", attributes: attributes)

        view.attributedText = section == 0 ? infoHeader : currenciesHeader
        return view
    }
    
    // MARK: - Private methods
    private func fetchData() {
        NetworkManager.shared.fetchMarketBy(id: exchange.exchange_id) { result in
            switch result {
            case .success(let markets):
                self.markets = markets
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
