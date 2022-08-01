//
//  NewsEntity.swift
//  StocksApp
//
//  Created by Aida Moldaly on 26.07.2022.
//

import Foundation

struct News: Codable {
    var category: String = ""
    var headline: String = ""
    var image: String = ""
    var datetime: Date
    var source: String = ""
    var summary: String = ""
    var url: String = ""
}

// https://finnhub.io/api/v1/news?category=general&token=cbfqc1aad3ictm4bs4l0

