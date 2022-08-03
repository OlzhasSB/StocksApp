//
//  StockEntity.swift
//  StocksApp
//
//  Created by Olzhas Seiilkhanov on 26.07.2022.
//

import Foundation

protocol SkeletonableStockViewModel {
    associatedtype ViewModel = Self
    static var skeletonable: ViewModel { get }
}

struct Stock {
    let profile: Profile?
    let quote: Quote?
    let isFavourite: Bool?
}

struct Profile: Decodable {
    let logo: String
    let name: String
    let ticker: String
    let country: String
    let currency: String
    let exchange: String
    var ipo: String
    var finnhubIndustry: String
    var weburl: String
}

struct Quote: Decodable {
    let c: Double
    let d: Double
    var dp: Double
    let h: Double
    let l: Double
    let o: Double
    let pc: Double
}

extension Stock: SkeletonableStockViewModel {
    static let skeletonable: Self = .init(
        profile: Profile.init(logo: "https://static.finnhub.io/logo/87cb30d8-80df-11ea-8951-00000000092a.png", name: "Apple Inc", ticker: "AAPL", country: "US", currency: "USD", exchange: "NASDAQ/NMS (GLOBAL MARKET)", ipo: "1980-12-12", finnhubIndustry: "Technology", weburl: "https://www.apple.com/"),
        quote: Quote.init(c: 160.01, d: -1.5, dp: -0.9287, h: 162.41, l: 159.63, o: 160.1, pc: 161.51),
        isFavourite: false
    )
}

//extension Profile: SkeletonableStockViewModel {
//    static let skeletonable: Self = .init(
//         logo: "https://static.finnhub.io/logo/87cb30d8-80df-11ea-8951-00000000092a.png",
//         name: "Apple Inc",
//         ticker: "AAPL",
//         country: "US",
//         currency: "USD",
//         exchange: "NASDAQ/NMS (GLOBAL MARKET)",
//         ipo: "1980-12-12",
//         finnhubIndustry: "Technology",
//         weburl: "https://www.apple.com/"
//    )
//}
