//
//  DetailsDataDisplayManager.swift
//  StocksApp
//
//  Created by Aida Moldaly on 26.07.2022.
//

import UIKit

final class DetailsDataDisplayManager: NSObject {
    
    var filter: [FilterEntity] = []
    
    var onFilterDidSelect: ((String) -> Void)?
    var isCellDidSelected: Bool = false

    func defaultColor(with cell: FilterCollectionViewCell, index: Int, indexpath: IndexPath) {

        cell.backgroundColor = .systemGray6
        cell.categorylabel.textColor = .black
        cell.layer.cornerRadius = 15
        cell.layer.masksToBounds = true
        
        if isCellDidSelected == false && index == 0 {
            cell.backgroundColor = .black
            cell.categorylabel.textColor = .white
        }
    }
    
    func selectedColor(with cell: FilterCollectionViewCell, index: Int) {
    
        cell.backgroundColor = .black
        cell.categorylabel.textColor = .white
        cell.layer.cornerRadius = 15
        cell.layer.masksToBounds = true
    }
    
    func desectedColor(with cell: FilterCollectionViewCell) {
        cell.backgroundColor = .systemGray6
        cell.categorylabel.textColor = .black
        cell.layer.cornerRadius = 20
        cell.layer.masksToBounds = true
    }
}

extension DetailsDataDisplayManager: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filter.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCollectionViewCell", for: indexPath) as! FilterCollectionViewCell
        cell.categorylabel.text = filter[indexPath.row].filter
        
        if isCellDidSelected == false && indexPath.row == 0 {
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionView.ScrollPosition.centeredHorizontally)
        }

        defaultColor(with: cell, index: indexPath.row, indexpath: indexPath )
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onFilterDidSelect?(filter[indexPath.row].filter)
        
        if let cell = collectionView.cellForItem(at: indexPath) as? FilterCollectionViewCell {
            isCellDidSelected = true
            selectedColor(with: cell, index: indexPath.row )
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) as? FilterCollectionViewCell {
            desectedColor(with: cell)
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: filter[indexPath.row].filter.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)]).width + 25, height: 35)
//    }
}

