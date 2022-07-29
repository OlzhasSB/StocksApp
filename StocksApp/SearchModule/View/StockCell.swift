//
//  StockCell.swift
//  StocksApp
//
//  Created by Olzhas Seiilkhanov on 25.07.2022.
//

import UIKit

class StockCell: UITableViewCell {
    
    let nameLabel = UILabel()
    let logoImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp(with stock: Stock) {
        nameLabel.text = stock.profile?.name
        
        let url = URL(string: stock.profile?.logo ?? "")
        logoImageView.kf.setImage(with: url)
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
