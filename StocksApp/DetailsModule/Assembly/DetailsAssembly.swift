//
//  DetailsAssembly.swift
//  StocksApp
//
//  Created by Aida Moldaly on 26.07.2022.
//

import UIKit

final class DetailsAssembly {
    
    func assemle() -> UIViewController {
        
        let dataDisplayManager = DetailsDataDisplayManager()
        let viewController = DetailsViewController()
        let presenter = DetailsPresenter()
        let network: Networkable = NetworkManager.shared
        let interactor = DetailsInteractor(network: network)
        let router = DetailsRouter()
        
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
