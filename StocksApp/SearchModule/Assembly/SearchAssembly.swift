//
//  SearchAssembly.swift
//  StocksApp
//
//  Created by Olzhas Seiilkhanov on 25.07.2022.
//

import UIKit

typealias SearchModuleConfiguration = () -> Void

final class SearchModuleAssembly {
    func assemble(_ configuration: SearchModuleConfiguration? = nil) -> SearchViewController {
        let dataDisplayManager = SearchDataDisplayManager()
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        let presenter = SearchPresenter()
        let network: Networkable = AlamofireNetworkManager.shared
        let interactor = SearchInteractor(networkManager: network)
        let router = SearchRouter()
        
        configuration?(presenter)
        
        viewController.dataDisplayManager = dataDisplayManager
        viewController.output = presenter
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.output = presenter
        
        router.viewController = viewController
        
        return viewController
    }
}
