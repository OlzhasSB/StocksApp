//
//  NewsPresenter.swift
//  StocksApp
//
//  Created by Olzhas Seiilkhanov on 25.07.2022.
//

import Foundation

final class NewsPresenter: NewsViewOutput, NewsInteractorOutput, NewsModuleInput {
    
    weak var view: NewsViewInput!
    var interactor: NewsInteractorInput!
    var router: NewsRouterInput!
    
    private var categories: [NewsCategoriesEntity] = [
        NewsCategoriesEntity.init(category: "All"),
        NewsCategoriesEntity.init(category: "Top news"),
        NewsCategoriesEntity.init(category: "Technology"),
        NewsCategoriesEntity.init(category: "Business")
    ]
    
    func didLoadView() {
//        <#code#>
    }
    
    func didSelectCategoryCell(with category: String) {
//        <#code#>
    }
    
    func didLoadNews(_ news: News) {
//        <#code#>
    }
    
    func didFilteredNews(_ news: News) {
//        <#code#>
    }
}
