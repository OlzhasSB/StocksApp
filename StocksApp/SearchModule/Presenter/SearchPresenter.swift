//
//  SearchPresenter.swift
//  StocksApp
//
//  Created by Olzhas Seiilkhanov on 25.07.2022.
//

import Foundation

final class SearchPresenter: SearchViewOutput {
    
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
        interactor.obtainLookupList(text)
    }
    
    func didTapCancelSearchBar() {
        view.handleSearchBarCancel()
    }
    
    func didResignSearchBar() {
        interactor.obtainStocksList()
    }

}

extension SearchPresenter: SearchInteractorOutput {
    
//    func didLoadShortList(_ shortList: [Ticker]) {
//        interactor.obtainProfile(with: shortList)
//    }
//
//    func didLoadStock(_ stock: Profile) {
//        view.handleObtainedStock(stock)
//    }
//
//    func didLoadLookupList(_ lookupList: [Ticker]) {
//        view.handleObtainedLookupList(lookupList)
//    }
//
//    func didLoadCandle(_ candle: Candle) {
//
//    }
    
    func didLoadStocksList(_ stocksList: [Stock]) {
        view.handleObtainedStocksList(stocksList)
    }
    
}
