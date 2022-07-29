//
//  NewsPresenter.swift
//  StocksApp
//
//  Created by Olzhas Seiilkhanov on 25.07.2022.
//

import Foundation

final class NewsPresenter: NewsViewOutput, NewsInteractorOutput {
    
    weak var view: NewsViewInput!
    var interactor: NewsInteractorInput!
    var router: NewsRouterInput!
    
    private var categories: [NewsCategoriesEntity] = [
        NewsCategoriesEntity.init(category: "All"),
        NewsCategoriesEntity.init(category: "top news"),
        NewsCategoriesEntity.init(category: "business"),
        NewsCategoriesEntity.init(category: "technology")
    ]
    private var news: [News] = []
    
    func didLoadView() {
        interactor.obtainNews()
        view.hundleObtainedNewsCategories(categories)
        view.hundleObtainedNews(news)
    }
    
    func didSelectCategoryCell(with category: String) {
        interactor.ontainFilteredNews(with: news, category: category)
    }
    
    func didSelectNewsUrlCell(with url: String) {
        router.openNewsWebsite(with: url)
    }
    
    func didLoadNews(_ news: [News]) {
        self.news = news
        view.hundleObtainedNews(news)
    }
    
    func didFilteredNews(_ news: [News]) {
        view.hundleObtainedNews(news)
    }

}
