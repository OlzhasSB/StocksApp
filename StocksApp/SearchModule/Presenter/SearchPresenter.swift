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
        // Network запрос - interactor
        interactor.obtainStocksList()
    }
    
    func didLoadStocksList(_ stocksList: [Ticker]) {
        view.handleObtainedStocks(stocksList)
    }
}
