//
//  SearchPresenter.swift
//  StocksApp
//
//  Created by Olzhas Seiilkhanov on 25.07.2022.
//

import Foundation

final class SearchPresenter: SearchViewOutput, SearchInteractorOutput {
    
    weak var view: SearchViewInput!
    var interactor: SearchInteractorInput!
    var router: SearchRouterInput!
    
    func didLoadView() {
        interactor.obtainStocksList()
    }
    
    func didTapSearchBar() {
        view.handleSearchBarTap()
    }
    
    func didStartEditingSearchBar(_ text: String) {
        let isHidden = interactor.shouldHideSearchView(text)
        view.handleSearchBarTextEditing(isHidden)
    }
    
    func didLoadStocksList(_ tickersList: [Ticker]) {
        view.handleObtainedStocks(tickersList)
    }
}
