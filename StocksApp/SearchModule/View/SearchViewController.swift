//
//  SearchViewController.swift
//  StocksApp
//
//  Created by Olzhas Seiilkhanov on 25.07.2022.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {
    
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
    
    private let searchBar = UISearchBar()
    private let categoriesCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 25, height: 40)
        layout.minimumLineSpacing = 1
    
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(CategoryCell.self, forCellWithReuseIdentifier: "categoryCell")
        return collection
    }()
    private let stocksListTable: UITableView = {
        let table = UITableView()
        table.register(StockCell.self, forCellReuseIdentifier: "stockCell")
        return table
    }()
    
    var dataDisplayManager: SearchDataDisplayManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableCollectionViews()
        makeConstraints()
    }
    
    private func configureTableCollectionViews() {
        categoriesCollection.delegate = dataDisplayManager
        categoriesCollection.dataSource = dataDisplayManager
        
        stocksListTable.delegate = dataDisplayManager
        stocksListTable.dataSource = dataDisplayManager
    }
    
    private func makeConstraints() {
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
        
        view.addSubview(categoriesCollection)
        categoriesCollection.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(searchBar.snp.bottom)
            make.height.equalTo(150)
        }
        
        view.addSubview(stocksListTable)
        stocksListTable.snp.makeConstraints { make in
            make.top.equalTo(categoriesCollection.snp.bottom)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCell
        return cell
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocksList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell") as! StockCell
        cell.textLabel?.text = stocksList[indexPath.row]
        return cell
    }
    
}
