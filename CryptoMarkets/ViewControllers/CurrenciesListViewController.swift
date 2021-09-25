//
//  CurrenciesListViewController.swift
//  CryptoMarkets
//
//  Created by Nadzeya Shpakouskaya on 25/09/2021.
//

import UIKit

class CurrenciesListViewController: UITableViewController {
    let dataManager = NetworkManager.shared
    var currencies: [Currency] = []

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        dataManager.fetchAllCurrencies() { result in
                   switch result {
       
                   case .success(let currencies):
                       self.currencies = currencies
                       DispatchQueue.main.async {
                           self.activityIndicator.isHidden = true
                           self.tableView.reloadData()
                       }
 
                       print(currencies)
              
                   case .failure(let error):
                       print(error)
                   }
               }
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
 

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailedVC = segue.destination as? MarketsByCurrencyViewController else { return }
        guard let index = tableView.indexPathForSelectedRow  else { return }
        detailedVC.currency = currencies[index.row]
    }
}
