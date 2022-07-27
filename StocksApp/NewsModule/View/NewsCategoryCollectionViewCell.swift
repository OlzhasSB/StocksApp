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
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Constraints

    func setUpConstraints(){
        
        
        contentView.addSubview(categorylabel)
        categorylabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(2)
            make.left.equalTo(contentView.snp.left).offset(10)
            make.right.equalTo(contentView.snp.right).offset(-10)
            make.bottom.equalTo(contentView).offset(-2)
        }
    }
}
