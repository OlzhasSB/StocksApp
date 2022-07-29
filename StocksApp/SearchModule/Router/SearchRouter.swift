//
//  SearchRouter.swift
//  StocksApp
//
//  Created by Olzhas Seiilkhanov on 25.07.2022.
//

import UIKit

protocol SearchRouterInput {
    func openDetailsModule()
}

final class SearchRouter: SearchRouterInput {
    weak var viewController: UIViewController?
    
    func openDetailsModule() {

        let viewController = DetailsAssembly().assemle()
//        { (input) in
//            input.configure(with: cast)
//        }
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
}
