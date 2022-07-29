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
    func didSelectTickerCell()
}

protocol SearchViewInput: AnyObject {
    func handleObtainedStock(_ stock: Stock)
    func handleObtainedLookupList(_ lookupList: [Ticker])
    func handleSearchBarTap()
    func handleSearchBarTextEditing(_ isHidden: Bool)
    func handleSearchBarCancel()
}

class SearchViewController: UIViewController {
     
    private let searchLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "Search"
        label.font = UIFont.boldSystemFont(ofSize: 30.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.backgroundImage = UIImage()
        return bar
    }()
    
    private let stocksListTable: UITableView = {
        let table = UITableView()
        table.register(StockCell.self, forCellReuseIdentifier: "stockCell")
        table.showsVerticalScrollIndicator = false
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
        setUpNaviagtionController()
    }
    
    private func configureTableCollectionViews() {
        
        dataDisplayManager?.onTickerDidSelect = { [weak self] in
            self?.output?.didSelectTickerCell()
        }
        
        categoriesCollection.delegate = dataDisplayManager
        categoriesCollection.dataSource = dataDisplayManager
        
        stocksListTable.delegate = dataDisplayManager
        stocksListTable.dataSource = dataDisplayManager
    }
    
    private func configureSearchBar() {
        searchBar.delegate = searchBarManager
        searchBarManager?.onSearchBarTapped = { [weak self] in
            self?.output?.didTapSearchBar()
        }
        searchBarManager?.onSearchBarTextEditing = { [weak self] text in
            self?.output?.didStartEditingSearchBar(text)
        }
        searchBarManager?.onSearchBarCancelTapped = { [weak self] in
            self?.output?.didTapCancelSearchBar()
        }
    }
    
    // MARK: - Setup NavigationController
    
    func setUpNaviagtionController() {
        navigationItem.title = ""
        self.navigationController?.view.backgroundColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }
    
    // MARK: - Constraints
    
    private func makeConstraints() {
        view.addSubview(searchLabel)
        searchLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(-27)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
        
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(searchLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
        
        view.addSubview(stocksListTable)
        stocksListTable.snp.makeConstraints { make in
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

}

extension SearchViewController: SearchViewInput {
    
    func handleObtainedStock(_ stock: Stock) {
        dataDisplayManager?.tickersList.append(stock)
        stocksListTable.reloadData()
    }
    
    func handleObtainedLookupList(_ lookupList: [Ticker]) {
        dataDisplayManager?.tickersList.removeAll()
        for index in 0..<lookupList.count {
            dataDisplayManager?.tickersList.append(Stock(logo: "", name: lookupList[index].description, ticker: lookupList[index].displaySymbol))
        }
        stocksListTable.reloadData()
    }
    
    func handleSearchBarTap() {
        searchView.isHidden = false
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func handleSearchBarTextEditing(_ isHidden: Bool) {
        searchView.isHidden = isHidden
    }
    
    func handleSearchBarCancel() {
        dataDisplayManager?.tickersList.removeAll()
        stocksListTable.reloadData()
        searchBar.setShowsCancelButton(false, animated: true)
        searchView.isHidden = true
        searchBar.resignFirstResponder()
        searchBar.text = ""

        output?.didResignSearchBar()
    }
    
}
