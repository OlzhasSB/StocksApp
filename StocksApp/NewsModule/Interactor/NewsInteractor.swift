//
//  NewsInteractor.swift
//  StocksApp
//
//  Created by Olzhas Seiilkhanov on 25.07.2022.
//

import Foundation

protocol NewsInteractorInput {
    func obtainNews()
    func ontainFilteredNews()
}

protocol NewsInteractorOutput: AnyObject {
    // Отправляет загруженные с network данные в Presenter
    func didLoadNews(_ news: News)
    func didFilteredNews(_ news: News)
}

final class NewsInteractor: NewsInteractorInput {

    weak var output: NewsInteractorOutput!
    private var network: Networkable
    
    required init(network: Networkable) {
        self.network = network
    }
    
    func obtainNews() {
        network.loadNews(path: "/api/v1/news") { [weak self] news in
//            self?.output.didLoadNews(news)
        }
    }
    
    func ontainFilteredNews() {
//        <#code#>
    }
}
