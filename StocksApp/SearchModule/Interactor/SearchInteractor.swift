//
//  SearchInteractor.swift
//  StocksApp
//
//  Created by Olzhas Seiilkhanov on 25.07.2022.
//

import Foundation

protocol SearchInteractorInput {
    func obtainStocksList()
    func obtainLookupList(_ symbol: String)
}

protocol SearchInteractorOutput: AnyObject {
    func didLoadStocksList(_ stocksList: [Stock])
}

final class SearchInteractor: SearchInteractorInput {
    
    weak var output: SearchInteractorOutput!
    private var networkManager: Networkable
    
    required init(networkManager: Networkable) {
        self.networkManager = networkManager
    }
    
    func obtainStocksList() {
        let queryItem = [
            URLQueryItem(name: "exchange", value: "US"),
            URLQueryItem(name: "mic", value: "XNYS")
            ]
        
        networkManager.fetchData(path: "/api/v1/stock/symbol", queryItems: queryItem) { [weak self] (result : Result <[Ticker], APINetworkError>) in
            switch result {
            case .success(let tickersList):
                let shortList = Array(tickersList.prefix(30))
                self?.obtainProfile(with: shortList)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func obtainLookupList(_ symbol: String) {
        let queryItem = [URLQueryItem(name: "q", value: symbol)]
        
        networkManager.fetchData(path: "/api/v1/search", queryItems: queryItem) { [weak self] (result : Result <LookupEntity, APINetworkError>) in
            switch result {
            case .success(let list):
                let lookupList = Array(list.result.prefix(30))
                self?.obtainProfile(with: lookupList)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func obtainProfile(with list: [Ticker]) {
        var profileList: [Profile] = []
        let group = DispatchGroup.init()
        
        for index in 0..<list.count {
            let queryItem = [URLQueryItem(name: "symbol", value: list[index].displaySymbol)]
            
            group.enter()
            networkManager.fetchData(path: "/api/v1/stock/profile2", queryItems: queryItem) { (result : Result <Profile, APINetworkError>) in
                switch result {
                case .success(let profile):
                    profileList.append(profile)
                    group.leave()
                
                case .failure(let error):
                    print(error.localizedDescription)
                    group.leave()
                }
            }
        }
        group.notify(queue: .main) {
            self.obtainQuote(with: profileList)
                              
        }
    }
    
    func obtainQuote(with profileList: [Profile]) {
        var stocksList: [Stock] = []

        let group = DispatchGroup.init()
        
        for index in 0..<profileList.count {
            let queryItem = [
                URLQueryItem(name: "symbol", value: profileList[index].ticker)
            ]
            
            group.enter()
            networkManager.fetchData(path: "/api/v1/quote", queryItems: queryItem) { (result : Result <Quote, APINetworkError>) in
                switch result {
                case .success(var quote):
                    quote.dp = round(quote.dp * 100)/100
                    let stock = Stock(profile: profileList[index], quote: quote, isFavourite: Bool())
                    stocksList.append(stock)
                    group.leave()
                case .failure(let error):
                    print(error.localizedDescription)
                    group.leave()
                }
            }
        }
        group.notify(queue: .main) {
            self.output.didLoadStocksList(stocksList)
        }
    }
    
    func getPriceData(with quote: Quote) -> (Double, Double, Double) {
        
        let currentPrice = quote.c
        let change = round(quote.c - quote.o * 100) / 100.0
        let changePercent = round(change/quote.o * 100 * 100) / 100.0
        
        let priceData = (currentPrice, change, changePercent)
        return priceData
    }
    

    
}
