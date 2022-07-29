//
//  SearchDataDisplayManager.swift
//  StocksApp
//
//  Created by Olzhas Seiilkhanov on 25.07.2022.
//

import UIKit

final class SearchDataDisplayManager: NSObject, UITableViewDelegate, UITableViewDataSource {
    
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
    var tickersList: [Stock] = []
    
    var onTickerDidSelect: (() -> Void)?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tickersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell") as! StockCell
        cell.setUp(with: tickersList[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onTickerDidSelect?()
    }
}

extension SearchDataDisplayManager: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCell
        return cell
    }
    
}
