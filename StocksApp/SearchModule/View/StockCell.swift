//
//  StockCell.swift
//  StocksApp
//
//  Created by Olzhas Seiilkhanov on 25.07.2022.
//

import UIKit

class StockCell: UITableViewCell {
    
    let companyName = UILabel()
    
    private let logo: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 5
        image.layer.masksToBounds = true
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp(with stock: Stock) {
        nameLabel.text = stock.profile?.name
        
        if stock.logo != "" {
            let url = URL(string: stock.logo)
            logo.kf.setImage(with: url)
        } else {
            logo.image = UIImage(named: "default.jpeg")
        }
    }
    
    private func makeConstraints() {
        contentView.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(16)
            make.bottom.equalTo(contentView).offset(-16)
            make.leading.equalTo(contentView).offset(30)
            make.height.width.equalTo(30)
        }
        
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(logoImageView.snp.trailing).offset(30)
            make.centerY.equalTo(contentView)
        }
    }

}
