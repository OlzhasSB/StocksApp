//
//  SearchInteractor.swift
//  StocksApp
//
//  Created by Olzhas Seiilkhanov on 25.07.2022.
//

import Foundation

protocol SearchInteractorInput {
    func obtainStocksList()
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
    
    func obtainStocksList() {
        let queryItem = URLQueryItem(name: "exchange", value: "US")
        networkManager.loadStocks(path: "/api/v1/stock/symbol", queryItem: queryItem) { [weak self] (result) in
            switch result {
            case .success(let tickersList):
                let stocksList
                for index in 0..<49 {
                    
                }
                self?.output.didLoadStocksList(stocksList)
            case .failure(let error):
                print(error)
            }
        }
        
        
        
        
    }
    
    
    
}
