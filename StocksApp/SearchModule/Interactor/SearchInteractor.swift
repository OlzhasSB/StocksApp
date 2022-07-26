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
    func didLoadStocksList(_ stocksList: [Stock])
}

final class SearchInteractor: SearchInteractorInput {
    
    weak var output: SearchInteractorOutput!
    private var networkManager: Networkable
    
    var stocksList: [Stock] = []
    
    required init(networkManager: Networkable) {
        self.networkManager = networkManager
    }
    
    func obtainStocksList() {
        networkManager.loadStocks(path: "/api/v1/stock/symbolexchange=US") { [weak self] (result) in
            switch result {
            case .success(let stocksList):
                self?.output.didLoadStocksList(stocksList)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

    }
    
}
