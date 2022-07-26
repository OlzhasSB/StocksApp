//
//  NewsViewController.swift
//  StocksApp
//
//  Created by Olzhas Seiilkhanov on 25.07.2022.
//

import UIKit

protocol NewsViewInput: AnyObject {
    func hundleObtainedNewsCategories(_ categories: NewsCategoriesEntity)
    func hundleObtainedNews(_ news: [News])
}

protocol NewaViewOutput {
    func didLoadView()
}

class NewsViewController: UIViewController {

    var output: NewaViewOutput?
    var dataDisplayManager: NewsDataDisplayManager?
    
    private let categoriesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 25, height: 40)
        layout.minimumLineSpacing = 1
    
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(CategoryCell.self, forCellWithReuseIdentifier: "categoryCell")
        return collection
    }()
    private let newsTableView: UITableView = {
        let table = UITableView()
        table.register(StockCell.self, forCellReuseIdentifier: "stockCell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output?.didLoadView()
        configureTableCollectionViews()
        makeConstraints()
    }
    
    private func configureTableCollectionViews() {
        categoriesCollectionView.delegate = dataDisplayManager
        categoriesCollectionView.dataSource = dataDisplayManager
        
        newsTableView.delegate = dataDisplayManager
        newsTableView.dataSource = dataDisplayManager
    }
    
    private func makeConstraints() {
        
        view.addSubview(categoriesCollectionView)
        categoriesCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(searchBar.snp.bottom)
            make.height.equalTo(150)
        }
        
        view.addSubview(newsTableView)
        newsTableView.snp.makeConstraints { make in
            make.top.equalTo(categoriesCollection.snp.bottom)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

}

extension NewsViewController: NewsViewInput {
    
    func hundleObtainedNewsCategories(_ categories: NewsCategoriesEntity) {
        <#code#>
    }
    
    func hundleObtainedNews(_ news: [News]) {
        <#code#>
    }
    
}
