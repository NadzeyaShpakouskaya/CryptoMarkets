//
//  CurrenciesListViewController.swift
//  CryptoMarkets
//
//  Created by Nadzeya Shpakouskaya on 25/09/2021.
//

import UIKit

class CurrenciesListViewController: UITableViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    // MARK: - Private properties
    private var currencies: [Currency] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllCurrencies()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currencies.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currencyDefaultCell", for: indexPath) as! CurrencyTableViewCell
        let currency = currencies[indexPath.row]
        cell.configureCellFor(currency)
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailedVC = segue.destination as? MarketsByCurrencyViewController else { return }
        guard let index = tableView.indexPathForSelectedRow  else { return }
        detailedVC.currency = currencies[index.row]
    }
    
    // MARK: - Private methods
    private func fetchAllCurrencies() {
        NetworkManager.shared.fetchAllCurrencies() { result in
            switch result {
            case .success(let currencies):
                self.currencies = currencies
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
