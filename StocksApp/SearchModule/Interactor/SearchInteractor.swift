//
//  SearchInteractor.swift
//  StocksApp
//
//  Created by Olzhas Seiilkhanov on 25.07.2022.
//

import Foundation

protocol SearchInteractorInput {
    func obtainStocksList()
    func shouldHideSearchView(_ text: String) -> Bool
}

protocol SearchInteractorOutput: AnyObject {
    func didLoadStocksList(_ stocksList: [Ticker])
}

final class SearchInteractor: SearchInteractorInput {
    
    weak var output: SearchInteractorOutput!
    private var networkManager: Networkable
    
    required init(networkManager: Networkable) {
        self.networkManager = networkManager
    }
    
    func shouldHideSearchView(_ text: String) -> Bool {
        let isHidden: Bool
        if text == "" {
            isHidden = false
        } else {
            isHidden = true
        }
        return isHidden
    }
    
    func obtainStocksList() {
        let queryItem = URLQueryItem(name: "exchange", value: "US")
        
        networkManager.fetchData(path: "/api/v1/stock/symbol", queryItem: queryItem) { [weak self] (result : Result <[Ticker], APINetworkError>) in
            switch result {
            case .success(let tickersList):
                for index in 0..<49 {

                }
                self?.output.didLoadStocksList(tickersList)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
