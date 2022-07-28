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
        interactor.obtainShortList()
    }
    
    func didTapSearchBar() {
        view.handleSearchBarTap()
    }
    
    func didStartEditingSearchBar(_ text: String) {
        interactor.shouldHideSearchView(text)
        interactor.lookupSymbol(text)
    }
    
    func didTapCancelSearchBar() {
        view.handleSearchBarCancel()
    }
    
    func didResignSearchBar() {
        interactor.obtainShortList()
    }

}

extension SearchPresenter: SearchInteractorOutput {
    
    func hideSearchView(_ isHidden: Bool) {
        view.handleSearchBarTextEditing(isHidden)
    }
    
    func didLoadShortList(_ shortList: [Ticker]) {
        interactor.obtainStock(with: shortList)
    }
    
    func didLoadStock(_ stock: Stock) {
        view.handleObtainedStock(stock)
    }
    
    func didLoadLookupList(_ lookupList: [Ticker]) {
        view.handleObtainedLookupList(lookupList)
    }
    
}
