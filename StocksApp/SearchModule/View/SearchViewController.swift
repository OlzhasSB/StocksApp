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
    
    func didTapSearchBar()
    func didStartEditingSearchBar(_ text: String)
    func didTapCancelSearchBar()
    func didResignSearchBar()
}

protocol SearchViewInput: AnyObject {
//    func handleObtainedStock(_ stock: Profile)
//    func handleObtainedLookupList(_ lookupList: [Ticker])
//    func handleObtainedCandle(_ candle: Candle)
    func handleObtainedStocksList(_ stocksList: [Stock])
    
    func handleSearchBarTap()
    func handleSearchBarCancel()
}

class SearchViewController: UIViewController {
     
    private let searchLabel: UILabel = {
        let label = UILabel()
        label.text = "Search"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    private let searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.backgroundImage = UIImage()
        return bar
    }()
    
    private let stocksTable: UITableView = {
        let table = UITableView()
        table.register(StockCell.self, forCellReuseIdentifier: "stockCell")
        return table
    }()
    
    private let searchView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.isHidden = true
        return view
    }()
    private let categoriesLabel: UILabel = {
        let label = UILabel()
        label.text = "Explore categories:"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    private let categoriesCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 25, height: 40)
        layout.minimumLineSpacing = 1
    
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(CategoryCell.self, forCellWithReuseIdentifier: "categoryCell")
        collection.isHidden = true
        return collection
    }()
    private let historyLabel: UILabel = {
        let label = UILabel()
        label.text = "You've searched for this:"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    private let historyCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 25, height: 40)
        layout.minimumLineSpacing = 1
    
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(CategoryCell.self, forCellWithReuseIdentifier: "categoryCell")
        collection.isHidden = true
        return collection
    }()
    
    var output: SearchViewOutput?
    var dataDisplayManager: SearchDataDisplayManager?
    var searchBarManager: SearchBarManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.didLoadView()
        
        configureTableCollectionViews()
        configureSearchBar()
        makeConstraints()
    }
    
    private func configureTableCollectionViews() {
        categoriesCollection.delegate = dataDisplayManager
        categoriesCollection.dataSource = dataDisplayManager
        
        stocksTable.delegate = dataDisplayManager
        stocksTable.dataSource = dataDisplayManager
    }
    
    private func configureSearchBar() {
        searchBar.delegate = searchBarManager
        searchBarManager?.onSearchBarTapped = { [weak self] in
            self?.output?.didTapSearchBar()
        }
        searchBarManager?.onSearchBarTextEditing = { [weak self] text in
            self?.handleSearchBarTextEditing(text)
        }
        searchBarManager?.onSearchBarCancelTapped = { [weak self] in
            self?.output?.didTapCancelSearchBar()
        }
    }
    
    private func makeConstraints() {
        view.addSubview(searchLabel)
        searchLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
        
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(searchLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
        
        view.addSubview(stocksTable)
        stocksTable.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        view.addSubview(searchView)
        searchView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        searchView.addSubview(categoriesLabel)
        categoriesLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(searchView).offset(16)
        }
        
        searchView.addSubview(categoriesCollection)
        categoriesCollection.snp.makeConstraints { make in
            make.leading.trailing.equalTo(searchView)
            make.top.equalTo(categoriesLabel.snp.bottom)
            make.height.equalTo(150)
        }
        
        searchView.addSubview(historyLabel)
        historyLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(searchView).offset(16)
            make.top.equalTo(categoriesCollection.snp.bottom)
        }
        
        searchView.addSubview(historyCollection)
        historyCollection.snp.makeConstraints { make in
            make.leading.trailing.equalTo(searchView)
            make.top.equalTo(historyLabel.snp.bottom)
        }
    }
    
    func handleSearchBarTextEditing(_ text: String) {
        let isHidden: Bool
        if text == "" {
            isHidden = false
        } else {
            output?.didStartEditingSearchBar(text)
            isHidden = true
        }
        searchView.isHidden = isHidden
    }

}

extension SearchViewController: SearchViewInput {
    
//    func handleObtainedStock(_ stock: Profile) {
//
//        dataDisplayManager?.tickersList.append(stock)
//        stocksListTable.reloadData()
//    }
//
//    func handleObtainedLookupList(_ lookupList: [Ticker]) {
//        dataDisplayManager?.tickersList.removeAll()
//        for index in 0..<lookupList.count {
//            dataDisplayManager?.tickersList.append(Profile(logo: "", name: lookupList[index].description, ticker: lookupList[index].displaySymbol))
//        }
//        stocksListTable.reloadData()
//    }
    
//    func handleObtainedCandle(_ candle: Candle) {
//
//    }
    
    func handleObtainedStocksList(_ stocksList: [Stock]) {
        dataDisplayManager?.stocksList.removeAll()
        dataDisplayManager?.stocksList = stocksList
        stocksTable.reloadData()
    }
    
    func handleSearchBarTap() {
        searchView.isHidden = false
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func handleSearchBarCancel() {
        dataDisplayManager?.stocksList.removeAll()
        stocksTable.reloadData()
        searchBar.setShowsCancelButton(false, animated: true)
        searchView.isHidden = true
        searchBar.resignFirstResponder()
        searchBar.text = ""
        output?.didResignSearchBar()
    }
    
}
