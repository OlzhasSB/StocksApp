//
//  NewsDataDisplayManager.swift
//  StocksApp
//
//  Created by Olzhas Seiilkhanov on 25.07.2022.
//

import Foundation
import UIKit
import Kingfisher


final class NewsDataDisplayManager: NSObject {
    
    var categories: [NewsCategoriesEntity] = []
    var news: [News] = []
    
    var onCategoryDidSelect: ((String) -> Void)?
    var onNewsUrlDidSelect: ((String) -> Void)?
    var isCellDidSelected: Bool = false
    
    func defaultColor(with cell: NewsCategoryCollectionViewCell, index: Int) {
        if isCellDidSelected == false && index == 0 {
            cell.backgroundColor = .black
            cell.categorylabel.textColor = .white
        } else if isCellDidSelected == true {
            cell.backgroundColor = .systemGray6
            cell.categorylabel.textColor = .black
        }
        cell.layer.cornerRadius = 17
        cell.layer.masksToBounds = true
    }
    
    func selectedColor(with cell: NewsCategoryCollectionViewCell, index: Int) {
    
        cell.backgroundColor = .black
        cell.categorylabel.textColor = .white
        cell.layer.cornerRadius = 17
        cell.layer.masksToBounds = true
    }
    
    func desectedColor(with cell: NewsCategoryCollectionViewCell) {
        cell.backgroundColor = .systemGray6
        cell.categorylabel.textColor = .black
        cell.layer.cornerRadius = 17
        cell.layer.masksToBounds = true
    }
}

extension NewsDataDisplayManager: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCategoryCollectionViewCell", for: indexPath) as! NewsCategoryCollectionViewCell
        cell.categorylabel.text = categories[indexPath.row].category
        defaultColor(with: cell, index: indexPath.row )
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onCategoryDidSelect?(categories[indexPath.row].category)
        
        if let cell = collectionView.cellForItem(at: indexPath) as? NewsCategoryCollectionViewCell {
            isCellDidSelected = true
            selectedColor(with: cell, index: indexPath.row )
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) as? NewsCategoryCollectionViewCell {
            desectedColor(with: cell)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: categories[indexPath.row].category.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)]).width + 25, height: 35)
    }
}

extension NewsDataDisplayManager: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
        cell.configure(with: news[indexPath.row])
        cell.selectionStyle = .none
        print("my celll is \(cell.configure(with: news[indexPath.row]))")
        cell.onWebsiteLinkButtonDidTap = { [weak self] in
            guard let self = self else { return }
            self.onNewsUrlDidSelect?(self.news[indexPath.row].url)
        }
        return cell
    }
}
