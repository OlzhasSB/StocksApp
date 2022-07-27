//
//  SearchBarManager.swift
//  StocksApp
//
//  Created by Olzhas Seiilkhanov on 27.07.2022.
//

import UIKit

final class SearchBarManager: NSObject, UISearchBarDelegate {
    
    var onSearchBarTapped: (() -> Void)?
    var onSearchBarTextEditing: ((String) -> Void)?
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        onSearchBarTextEditing?(searchText)
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        onSearchBarTapped?()
        return true
    }
    
}
