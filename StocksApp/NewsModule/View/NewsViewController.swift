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
        layout.itemSize = CGSize(width: 25, height: 40)
        layout.minimumLineSpacing = 1
    
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(NewsCategoryCollectionViewCell.self, forCellWithReuseIdentifier: "NewsCategoryCollectionViewCell")
        collection.backgroundColor = .blue
        return collection
    }()
    
    private let newsTableView: UITableView = {
        let table = UITableView()
        table.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsTableViewCell")
        table.backgroundColor = .red
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output?.didLoadView()
        setUpTableCollectionViews()
        makeConstraints()
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
            make.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(100)
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
