//
//  NewsCategoryCollectionViewCell.swift
//  StocksApp
//
//  Created by Aida Moldaly on 26.07.2022.
//

import UIKit

class NewsCategoryCollectionViewCell: UICollectionViewCell {
    
    let categorylabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
