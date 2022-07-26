//
//  NewsTableViewCell.swift
//  StocksApp
//
//  Created by Aida Moldaly on 26.07.2022.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    // MARK: - UIImageView, UIView, UILabel
    
    let newsImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 35
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    let headlinelabel: UILabel = {
         let label = UILabel()
         label.textColor = UIColor.black
         label.font = UIFont.boldSystemFont(ofSize: 20.0)
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
    }()

    let datetimeLabel: UILabel = {
         let label = UILabel()
         label.font = UIFont.systemFont(ofSize: 14)
         label.textColor = UIColor.darkGray
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
    }()

    let sourceLabel: UILabel = {
         let label = UILabel()
         label.font = UIFont.systemFont(ofSize: 14)
         label.textColor = UIColor.darkGray
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
    }()
    
    let summaryLabel: UILabel = {
         let label = UILabel()
         label.font = UIFont.systemFont(ofSize: 14)
         label.textColor = UIColor.darkGray
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
    }()

    let urlLabel: UILabel = {
         let label = UILabel()
         label.font = UIFont.systemFont(ofSize: 14)
         label.textColor = UIColor.systemGray3
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpConstraints()
     }

    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }

    // MARK: - Setup Constraints

    func setUpConstraints(){
        
        contentView.addSubview(newsImageView)
        newsImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(20)
            make.left.equalTo(contentView).offset(20)
            make.height.equalTo(70)
            make.width.equalTo(70)
        }
        
        contentView.addSubview(datetimeLabel)
        datetimeLabel.snp.makeConstraints { make in
            make.top.equalTo(newsImageView)
            make.left.equalTo(newsImageView).offset(20)
        }
        
        contentView.addSubview(sourceLabel)
        datetimeLabel.snp.makeConstraints { make in
            make.top.equalTo(newsImageView)
            make.left.equalTo(datetimeLabel).offset(20)
            make.right.equalTo(contentView).offset(-20)
        }
        
        contentView.addSubview(headlinelabel)
        headlinelabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(20)
            make.left.equalTo(contentView).offset(20)
            make.bottom.equalTo(contentView).offset(-20)
            make.right.equalTo(contentView).offset(-20)
        }
        
        contentView.addSubview(summaryLabel)
        summaryLabel.snp.makeConstraints { make in
            make.top.equalTo(newsImageView).offset(20)
            make.left.equalTo(contentView)
            make.right.equalTo(contentView).offset(-20)
        }
        
        contentView.addSubview(urlLabel)
        urlLabel.snp.makeConstraints { make in
            make.top.equalTo(summaryLabel).offset(20)
            make.left.equalTo(newsImageView)
            make.bottom.equalTo(contentView).offset(-20)
            make.right.equalTo(summaryLabel).offset(-20)
        }
    }

}
