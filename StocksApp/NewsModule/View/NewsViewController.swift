//
//  NewsViewController.swift
//  StocksApp
//
//  Created by Olzhas Seiilkhanov on 25.07.2022.
//

import UIKit
import HGPlaceholders
import SkeletonView

protocol NewsViewInput: AnyObject {
    func hundleObtainedNewsCategories(_ categories: [NewsCategoriesEntity])
    func hundleObtainedNews(_ news: [News])
    func showLoader()
    func hideLoader()
}

protocol NewsViewOutput {
    func didLoadView()
    func didSelectCategoryCell(with category: String)
    func didSelectNewsUrlCell(with url: String)
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
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 10)
        layout.minimumLineSpacing = 10
    
        var collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(NewsCategoryCollectionViewCell.self, forCellWithReuseIdentifier: "NewsCategoryCollectionViewCell")
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    private let newsTableView: UITableView = {
        let table = UITableView()
        table.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        table.showsVerticalScrollIndicator = false
        table.isSkeletonable = true
        table.estimatedRowHeight = 120.0
        table.rowHeight = UITableView.automaticDimension
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
        
        dataDisplayManager?.onNewsUrlDidSelect = { [ weak self] url in
            self?.output?.didSelectNewsUrlCell(with: url)
        }
        
        categoriesCollectionView.delegate = dataDisplayManager
        categoriesCollectionView.dataSource = dataDisplayManager
        
        newsTableView.delegate = dataDisplayManager
        newsTableView.dataSource = dataDisplayManager
    }
    
    
    private func makeConstraints() {
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(50)
        }
        
        view.addSubview(categoriesCollectionView)
        categoriesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
        
        view.addSubview(newsTableView)
        newsTableView.snp.makeConstraints { make in
            make.top.equalTo(categoriesCollectionView.snp.bottom).offset(5)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension NewsViewController: NewsViewInput {
    
    func showLoader() {
        newsTableView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .clouds), animation: nil, transition: .crossDissolve(0.25))
    }
    
    func hideLoader() {
        newsTableView.stopSkeletonAnimation()
        view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
    }
    
    func hundleObtainedNewsCategories(_ categories: [NewsCategoriesEntity]) {
        dataDisplayManager?.categories = categories
        categoriesCollectionView.reloadData()
        
        // select first item of collection view, when categories are loaded
        let indexPath:IndexPath = IndexPath(row: 0, section: 0)
        categoriesCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: .top)
    }
    
    func hundleObtainedNews(_ news: [News]) {
        dataDisplayManager?.news = news
        newsTableView.reloadData()
    }
}

