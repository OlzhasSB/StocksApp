//
//  DetailsInteractor.swift
//  StocksApp
//
//  Created by Aida Moldaly on 26.07.2022.
//

import Foundation

protocol DetailsInteractorInput {
//    func obtainNews()
//    func ontainFilteredNews(with news: [News], category: String)
}

protocol DetailsInteractorOutput: AnyObject {
    // Отправляет загруженные с network данные в Presenter
//    func didLoadNews(_ news: [News])
//    func didFilteredNews(_ news: [News])
}

final class DetailsInteractor: DetailsInteractorInput {

    weak var output: DetailsInteractorOutput!
    private var network: Networkable
    
    required init(network: Networkable) {
        self.network = network
    }
    
//    func obtainNews() {
//        let queryItem = URLQueryItem(name: "category", value: "general")
//        network.fetchData(path: "/api/v1/news", queryItem: queryItem) { [weak self] (result : Result <[News], APINetworkError>) in
//            switch result {
//            case .success(let news):
//                self?.output.didLoadNews(news)
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//    
//    func ontainFilteredNews(with news: [News], category: String) {
//        var filteredNews = news.filter { filteredNews in
//            if filteredNews.category == category {
//                return true
//            }
//            return false
//        }
//        if category == "All" {
//            filteredNews = news
//        }
//        output.didFilteredNews(filteredNews)
//    }
}
