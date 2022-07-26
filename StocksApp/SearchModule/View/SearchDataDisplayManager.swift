//
//  SearchDataDisplayManager.swift
//  StocksApp
//
//  Created by Olzhas Seiilkhanov on 25.07.2022.
//

import UIKit

final class SearchDataDisplayManager: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var categories = [
        "Undervalued Growth Stocks",
        "Growth Technology Stocks",
        "Day Gainers",
        "Day Losers",
        "Most Actives",
        "Undervalued Large Caps",
        "Aggressive Small Caps",
        "Small Cap Gainers"
    ]
    
    var stocksList = [
        "Apple",
        "Amazon",
        "Google"
    ]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCell
        return cell
    }
    
}

extension SearchDataDisplayManager: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocksList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell") as! StockCell
        cell.textLabel?.text = stocksList[indexPath.row]
        return cell
    }
    
}
