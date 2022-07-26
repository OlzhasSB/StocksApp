//
//  SearchViewController.swift
//  StocksApp
//
//  Created by Olzhas Seiilkhanov on 25.07.2022.
//

import UIKit
import SnapKit

protocol SearchViewOutput {
    func didLoadView()
}

protocol SearchViewInput: AnyObject {
    func handleObtainedStocks(_ stocksList: [Ticker])
}

class SearchViewController: UIViewController {
     
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
        table.backgroundColor = .systemGray5
        return table
    }()
    
    var output: SearchViewOutput?
    var dataDisplayManager: SearchDataDisplayManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.didLoadView()
        
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

extension SearchViewController: SearchViewInput {
    func handleObtainedStocks(_ stocksList: [Ticker]) {
        dataDisplayManager?.stocksList = stocksList
        stocksListTable.reloadData()
    }
}
