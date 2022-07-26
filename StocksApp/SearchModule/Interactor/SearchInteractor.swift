//
//  SearchInteractor.swift
//  StocksApp
//
//  Created by Olzhas Seiilkhanov on 25.07.2022.
//

import Foundation

protocol SearchInteractorInput {
    func obtainStocksList(with movie: Movie)
}

protocol SearchInteractorOutput: AnyObject {
    func didLoadStocksList(_ cast: [PersonEntity])
}

final class SearchInteractor: SearchInteractorInput {
    
    weak var output: SearchInteractorOutput!
    private var networkManager: Networkable
    
    var creditsIds: [Actor] = []
    
    required init(networkManager: Networkable) {
        self.networkManager = networkManager
    }
    
    func obtainStocksList(with movie: Movie) {
        
        var cast: [PersonEntity] = []
        let movieId = movie.id
        
        networkManager.getCredits(path: "/3/movie/\(movieId)/credits") { [weak self] ids in
            for id in ids {
                self?.networkManager.getCast(path: "/3/person/\(id.id)") { [weak self] person in
                    cast.append(person)
                    self?.output.didLoadMovieCast(cast)
                }
            }
        }
        

    }
    
}
