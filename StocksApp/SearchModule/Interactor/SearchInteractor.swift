//
//  SearchInteractor.swift
//  StocksApp
//
//  Created by Olzhas Seiilkhanov on 25.07.2022.
//

import Foundation

protocol SearchInteractorInput {
    func obtainShortList()
    func obtainStock(with list: [Ticker])
    func shouldHideSearchView(_ text: String)
    func lookupSymbol(_ symbol: String)
}

protocol SearchInteractorOutput: AnyObject {
    func didLoadShortList(_ shortList: [Ticker])
//    func didLoadStocksList(_ stocksList: [Stock])
    func didLoadStock(_ stock: Stock)
    func hideSearchView(_ isHidden: Bool)
    func didLoadLookupList(_ lookupList: [Ticker])
}

final class SearchInteractor: SearchInteractorInput {
    
    weak var output: SearchInteractorOutput!
    private var networkManager: Networkable
    
    required init(networkManager: Networkable) {
        self.networkManager = networkManager
    }
    
    func shouldHideSearchView(_ text: String) {
        let isHidden: Bool
        if text == "" {
            isHidden = false
        } else {
            isHidden = true
        }
        output.hideSearchView(isHidden)
    }
    
    func obtainShortList() {
        let queryItem = URLQueryItem(name: "exchange", value: "US")
        
        networkManager.fetchData(path: "/api/v1/stock/symbol", queryItem: queryItem) { [weak self] (result : Result <[Ticker], APINetworkError>) in
            
            switch result {
            case .success(let tickersList):
                let shortList = Array(tickersList.prefix(5))
                self?.output.didLoadShortList(shortList)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func obtainStock(with list: [Ticker]) {
        for index in 0..<list.count {
            let queryItem = URLQueryItem(name: "symbol", value: list[index].displaySymbol)
            networkManager.fetchData(path: "/api/v1/stock/profile2", queryItem: queryItem) { [weak self]
                (result : Result <Stock, APINetworkError>) in
                switch result {
                case .success(let stock):
                    self?.output?.didLoadStock(stock)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func lookupSymbol(_ symbol: String) {
        let queryItem = URLQueryItem(name: "q", value: symbol)
        networkManager.fetchData(path: "/api/v1/search", queryItem: queryItem) { [weak self] (result : Result <LookupEntity, APINetworkError>) in
            switch result {
            case .success(let lookupList):
                self?.output.didLoadLookupList(lookupList.result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
