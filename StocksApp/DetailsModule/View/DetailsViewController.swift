//
//  DetailsViewController.swift
//  StocksApp
//
//  Created by Aida Moldaly on 26.07.2022.
//

import UIKit

protocol DetailsViewInput: AnyObject {
//    func hundleObtainedNewsCategories(_ categories: [NewsCategoriesEntity])
//    func hundleObtainedNews(_ news: [News])
}

protocol DetailsViewOutput {
    func didLoadView()
//    func didSelectCategoryCell(with category: String)
//    func didSelectNewsUrlCell(with url: String)
}

class DetailsViewController: UIViewController {

    var output: DetailsViewOutput?
//    var dataDisplayManager: NewsDataDisplayManager?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "Details"
        label.font = UIFont.boldSystemFont(ofSize: 30.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmented = UISegmentedControl (items: ["Line","Candle"])
        segmented.frame = CGRect()
        segmented.selectedSegmentIndex = 0
        segmented.backgroundColor = .black
        segmented.tintColor = .white
//        segmented.selectedSegmentTintColor = .black
        segmented.addTarget(self, action: #selector(segmentAction(_:)), for: .valueChanged)
        return segmented
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        makeConstraints()
        output?.didLoadView()
    }
    
    @objc
    func segmentAction(_ sender: UISegmentedControl) {
        
        let index = sender.selectedSegmentIndex
        
        switch index {
        case 0:
            view.backgroundColor = .systemMint
        case 1:
            view.backgroundColor = .systemPink
        default:
            break
        }
    }
    
    private func makeConstraints() {
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(-15)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(50)
        }
        
        view.addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
//        view.addSubview(newsTableView)
//        newsTableView.snp.makeConstraints { make in
//            make.top.equalTo(categoriesCollectionView.snp.bottom).offset(5)
//            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
//        }
    }
}
