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
//    func obtainProfile(with list: [Ticker])
//    func obtainCandle(with profileList: [Profile])
}

protocol SearchInteractorOutput: AnyObject {
//    func didLoadShortList(_ shortList: [Ticker])
//    func didLoadStock(_ stock: Profile)
//    func didLoadLookupList(_ lookupList: [Ticker])
//    func didLoadCandle(_ candle: Candle)
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
                let shortList = Array(tickersList.prefix(10))
//                self?.output.didLoadShortList(shortList)
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
//                self?.output.didLoadLookupList(lookupList.result)
                let lookupList = Array(list.result.prefix(10))
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
//                    self?.output?.didLoadStock(stock)
                    profileList.append(profile)
                    group.leave()
                
                case .failure(let error):
                    print(error.localizedDescription)
                    group.leave()
                }
            }
        }
        group.notify(queue: .main) {
            self.obtainCandle(with: profileList)
        }
    }
    
    func obtainCandle(with profileList: [Profile]) {
        
        var stocksList: [Stock] = []
        
        let currentTime = 1631627048
//        Int(NSDate().timeIntervalSince1970) - 60*60
        let fromTime = 1631022248
        let group = DispatchGroup.init()
        
        for index in 0..<profileList.count {
            let queryItem = [
                URLQueryItem(name: "symbol", value: profileList[index].ticker),
                URLQueryItem(name: "resolution", value: "1"),
                URLQueryItem(name: "from", value: String(fromTime)),
                URLQueryItem(name: "to", value: String(currentTime))
            ]
            
            group.enter()
            networkManager.fetchData(path: "/api/v1/stock/candle", queryItems: queryItem) { (result : Result <Candle, APINetworkError>) in
                switch result {
                case .success(let candle):
//                    self?.output.didLoadCandle(candle)
                    
                    let stock = Stock(profile: profileList[index], candle: candle)
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
    

    
}
