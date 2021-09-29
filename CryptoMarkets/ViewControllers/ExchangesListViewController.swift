//
//  ExchangesListViewController.swift
//  CryptoMarkets
//
//  Created by Nadzeya Shpakouskaya on 25/09/2021.
//

import UIKit

class ExchangesListViewController: UITableViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Private properties
    private var exchanges: [Exchange] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllExchanges()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        exchanges.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exchangeCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = exchanges[indexPath.row].name
        content.textProperties.font = UIFont(name: "Geeza Pro Bold", size: 18) ?? .systemFont(ofSize: 18)
        content.textProperties.color = .darkGray
        cell.contentConfiguration = content
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailedVC = segue.destination as? DetailedExchangeViewController else { return }
        guard let index = tableView.indexPathForSelectedRow  else { return }
        let selectedExchange = exchanges[index.row]
        detailedVC.exchange = selectedExchange
    }
    
    // MARK: - Private methods
    private func fetchAllExchanges() {
        NetworkManager.shared.fetchAllExchanges { result in
            switch result {
            case .success(let exchanges):
                self.exchanges = exchanges
                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}
