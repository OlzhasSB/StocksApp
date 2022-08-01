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
        NewsCategoriesEntity.init(category: "Top news"),
        NewsCategoriesEntity.init(category: "Business"),
        NewsCategoriesEntity.init(category: "Technology")
    ]
    private var news: [News] = []
    
    func didLoadView() {
        interactor.obtainNews()
        view.hundleObtainedNewsCategories(categories)
        print(5)
        view.hundleObtainedNews(news)
    }
    
    func didSelectCategoryCell(with category: String) {
        interactor.ontainFilteredNews(with: news, category: category)
    }
    
    func didSelectNewsUrlCell(with url: String) {
        router.openNewsWebsite(with: url)
    }
    
    func didLoadNews(_ news: [News]) {
        print(3)
        self.news = news
        view.hundleObtainedNews(news)
    }
    
    func didFilteredNews(_ news: [News]) {
        view.hundleObtainedNews(news)
        print(4)
    }

}
