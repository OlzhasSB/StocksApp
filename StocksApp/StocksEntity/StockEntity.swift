//
//  StockEntity.swift
//  StocksApp
//
//  Created by Olzhas Seiilkhanov on 26.07.2022.
//

import Foundation

struct Stock {
    var profile: Profile?
    var quote: Quote?
    var ticker: Ticker?
    var isFavourite: Bool?
}

struct Profile: Decodable {
    var logo: String
    let name: String
    let ticker: String
    let country: String
    let currency: String
    let exchange: String
    var image: Data?
}

//struct Candle: Decodable {
//    let c: [Double]?
//    let h: [Double]?
//    let l: [Double]?
//    let o: [Double]?
//    let s: String?
//    let t: [Double]?
//    let v: [Double]?
//    let error: String?
//}

struct Quote: Decodable {
    let c: Double?
    let d: Double?
    var dp: Double?
    let h: Double?
    let l: Double?
    let o: Double?
    let pc: Double?
    let error: String?
}
