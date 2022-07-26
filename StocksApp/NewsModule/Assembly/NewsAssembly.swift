//
//  NewsAssembly.swift
//  StocksApp
//
//  Created by Olzhas Seiilkhanov on 25.07.2022.
//

import UIKit

protocol NewsModuleInput {
}

typealias NewsModuleConfiguration = (NewsModuleInput) -> Void

final class NewsModuleAssembly {
    
    func assemle(_ configuration: NewsModuleConfiguration? = nil) -> NewsViewController {
        
        let dataDisplayManager = NewsDataDisplayManager()
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "NewsViewController") as! NewsViewController
        let presenter = NewsPresenter()
        let network: Networkable = NetworkManager.shared
        let interactor = NewsInteractor(network: network)
        let router = NewsRouter()
        
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

