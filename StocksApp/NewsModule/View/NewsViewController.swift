//
//  NewsViewController.swift
//  StocksApp
//
//  Created by Olzhas Seiilkhanov on 25.07.2022.
//

import UIKit

protocol NewsViewInput: AnyObject {
    func hundleObtainedNewsCategories(_ categories: [NewsCategoriesEntity])
    func hundleObtainedNews(_ news: [News])
}

protocol NewsViewOutput {
    func didLoadView()
    func didSelectCategoryCell(with category: String)
}

class NewsViewController: UIViewController {

    var output: NewsViewOutput?
    var dataDisplayManager: NewsDataDisplayManager?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "News"
        label.font = UIFont.boldSystemFont(ofSize: 30.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let categoriesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
//        layout.itemSize = CGSize(width: 105, height: 40)
        layout.minimumLineSpacing = 10
    
        var collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(NewsCategoryCollectionViewCell.self, forCellWithReuseIdentifier: "NewsCategoryCollectionViewCell")
        collection.showsHorizontalScrollIndicator = false
//        collection.backgroundColor = .red

        return collection
    }()
    
    private let newsTableView: UITableView = {
        let table = UITableView()
        table.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsTableViewCell")
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableCollectionViews()
        makeConstraints()
        output?.didLoadView()
    }
    
    private func setUpTableCollectionViews() {
        
        dataDisplayManager?.onCategoryDidSelect = { [ weak self] category in
            self?.output?.didSelectCategoryCell(with: category)
        }
        
        categoriesCollectionView.delegate = dataDisplayManager
        categoriesCollectionView.dataSource = dataDisplayManager
        
        newsTableView.delegate = dataDisplayManager
        newsTableView.dataSource = dataDisplayManager
    }
    
    private func makeConstraints() {
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(90)
        }
        
        view.addSubview(categoriesCollectionView)
        categoriesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(-20)
            make.left.right.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(75)
        }
        
        view.addSubview(newsTableView)
        newsTableView.snp.makeConstraints { make in
            make.top.equalTo(categoriesCollectionView.snp.bottom).offset(-20)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension NewsViewController: NewsViewInput {
    
    func hundleObtainedNewsCategories(_ categories: [NewsCategoriesEntity]) {
        dataDisplayManager?.categories = categories
        categoriesCollectionView.reloadData()
    }
    
    func hundleObtainedNews(_ news: [News]) {
        dataDisplayManager?.news = news
        newsTableView.reloadData()
    }
    
}
