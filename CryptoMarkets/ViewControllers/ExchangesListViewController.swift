//
//  ExchangesListViewController.swift
//  CryptoMarkets
//
//  Created by Nadzeya Shpakouskaya on 25/09/2021.
//

import UIKit

class ExchangesListViewController: UITableViewController {
    let dataManager = NetworkManager.shared
    var exchanges: [Exchange] = []

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataManager.fetchAllExchanges { result in
                   switch result {
       
                   case .success(let exchanges):
                       self.exchanges = exchanges
                       DispatchQueue.main.async {
                           self.activityIndicator.isHidden = true
                           self.tableView.reloadData()
                       }
 
                       print(exchanges)
              
                   case .failure(let error):
                       print(error)
                   }
               }
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
        cell.contentConfiguration = content
        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailedVC = segue.destination as? DetailedExchangeViewController else { return }
        guard let index = tableView.indexPathForSelectedRow  else { return }
        let selectedExchange = exchanges[index.row]
        detailedVC.exchange = selectedExchange
    }


}
