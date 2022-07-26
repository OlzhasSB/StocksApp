//
//  NewsDataDisplayManager.swift
//  StocksApp
//
//  Created by Olzhas Seiilkhanov on 25.07.2022.
//

import Foundation
import UIKit

final class NewsDataDisplayManager: NSObject {
    
    var categories: [NewsCategoriesEntity] = []
    var news: [News] = []
    
    var onCategoryDidSelect: ((String) -> Void)?
}

extension NewsDataDisplayManager: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCategoryCollectionViewCell", for: indexPath) as! NewsCategoryCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onCategoryDidSelect?(categories[indexPath.row].category)
    }
}

extension NewsDataDisplayManager: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
        return cell
    }
}
