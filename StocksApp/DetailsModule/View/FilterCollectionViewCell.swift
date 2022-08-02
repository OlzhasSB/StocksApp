//
//  FilterCollectionViewCell.swift
//  StocksApp
//
//  Created by Aida Moldaly on 01.08.2022.
//

import UIKit

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    
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
    
    // MARK: - Setup Constraints

    func setUpConstraints(){
        
        contentView.addSubview(categorylabel)
        categorylabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(0)
            make.left.equalTo(contentView.snp.left).offset(0)
            make.right.equalTo(contentView.snp.right).offset(-0)
            make.bottom.equalTo(contentView).offset(-0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}