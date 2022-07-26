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
    
//    private var movie: Movie!
    
    func didLoadView() {
        // Network запрос - interactor
        
    }
    
    func didSelectCastCell(at cast: PersonEntity) {
        // переход на экран
    }
    
    func didLoadMovieCast(_ cast: [PersonEntity]) {
        // notify view
    }
    
}
