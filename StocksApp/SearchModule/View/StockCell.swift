//
//  StockCell.swift
//  StocksApp
//
//  Created by Olzhas Seiilkhanov on 25.07.2022.
//

import UIKit
import Kingfisher

class StockCell: UITableViewCell {
    
    let nameLabel = UILabel()
    
    private let logoImageVIew: UIImageView = {
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
        
        if let logo = stock.profile?.logo, logo != "" {
            let url = URL(string: logo)
            self.logoImageVIew.kf.setImage(with: url)
        } else {
            logoImageVIew.image = UIImage(named: "default.jpeg")
        }
    }
    
    private func makeConstraints() {
        contentView.addSubview(logoImageVIew)
        logoImageVIew.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(16)
            make.bottom.equalTo(contentView).offset(-16)
            make.leading.equalTo(contentView).offset(30)
            make.height.width.equalTo(30)
        }
        
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(logoImageVIew.snp.trailing).offset(30)
            make.centerY.equalTo(contentView)
        }
    }

}
