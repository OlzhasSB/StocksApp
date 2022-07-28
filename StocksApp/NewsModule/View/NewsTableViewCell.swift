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
        image.layer.cornerRadius = 5
        image.layer.masksToBounds = true
        return image
    }()

    let headlinelabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 25.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
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
        label.numberOfLines = 0
        return label
    }()

    let urlLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.systemGray3
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
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

    func configure(with news: News) {
        let url = URL(string: news.image)
        newsImageView.kf.setImage(with: url)
        datetimeLabel.text = "\(news.datetime)"
        sourceLabel.text = news.source
        headlinelabel.text = news.headline
        summaryLabel.text = news.summary
        urlLabel.text = news.url
//        "View on website"
//        if let url = URL(string: news.url) {
//            UIApplication.shared.open(url)
//        }
    }
    
    func setUpConstraints(){
        
        contentView.addSubview(newsImageView)
        newsImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(10)
            make.left.equalTo(contentView).offset(20)
            make.height.equalTo(30)
            make.width.equalTo(40)
        }
        
        contentView.addSubview(datetimeLabel)
        datetimeLabel.snp.makeConstraints { make in
            make.left.equalTo(newsImageView.snp.right).offset(15)
            make.centerY.equalTo(newsImageView)
        }

        contentView.addSubview(sourceLabel)
        sourceLabel.snp.makeConstraints { make in
            make.left.equalTo(datetimeLabel.snp.right).offset(10)
            make.centerY.equalTo(newsImageView)
        }

        contentView.addSubview(headlinelabel)
        headlinelabel.snp.makeConstraints { make in
            make.top.equalTo(newsImageView.snp.bottom).offset(10)
            make.left.equalTo(newsImageView.snp.left)
            make.right.equalTo(contentView).offset(-20)
        }

        contentView.addSubview(summaryLabel)
        summaryLabel.snp.makeConstraints { make in
            make.top.equalTo(headlinelabel.snp.bottom).offset(10)
            make.left.equalTo(newsImageView.snp.left)
            make.right.equalTo(headlinelabel.snp.right)
        }

        contentView.addSubview(urlLabel)
        urlLabel.snp.makeConstraints { make in
            make.top.equalTo(summaryLabel.snp.bottom).offset(5)
            make.left.equalTo(newsImageView.snp.left)
            make.right.equalTo(headlinelabel.snp.right)
            make.bottom.equalTo(contentView).offset(-10)
        }
    }

}
