//
//  StockEntity.swift
//  StocksApp
//
//  Created by Olzhas Seiilkhanov on 26.07.2022.
//

import Foundation

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
}

struct Candle: Decodable {
    let c: [Double]?
    let h: [Double]?
    let l: [Double]?
    let o: [Double]?
    let s: String?
    let t: [Double]?
    let v: [Double]?
    let error: String?
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
