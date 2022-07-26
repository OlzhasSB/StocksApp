//
//  NewsDataDisplayManager.swift
//  StocksApp
//
//  Created by Olzhas Seiilkhanov on 25.07.2022.
//

import Foundation
import UIKit

final class NewsDataDisplayManager: NSObject {
    
    var categories: [NewsCategoriesEntity] = []
    var news: [News] = [
        News.init(category: "top news", headline: "UK ‘Love Affair’ With Music Streaming Delivers for Britons: CMA", image: "https://data.bloomberglp.com/company/sites/2/2019/01/logobbg-wht.png", source: "Bloomberg", summary: "The music streaming market dominated by a handful of major players is giving consumers a fair shake, the UK’s antitrust watchdog said in a much anticipated report, as it pulled back from a deeper investigation into the likes of Spotify Technology SA and Apple…", url: "https://www.bloomberg.com/news/articles/2022-07-26/uk-love-affair-with-music-streaming-delivers-for-britons-cma"),
        News.init(category: "top news", headline: "Heathrow Blames Airlines for Flight Chaos, Says Cap to Stay", image: "https://data.bloomberglp.com/company/sites/2/2019/01/logobbg-wht.png", source: "Bloomberg", summary: "London Heathrow warned that there’s no prospect of lifting a cap on flights until airlines boost the number of ground personnel, saying carriers were too slow to combat staffing shortage that contributed to the travel chaos engulfing Europe this summer.", url: "https://www.bloomberg.com/news/articles/2022-07-26/heathrow-says-passenger-cap-to-stay-until-airlines-boost-hiring")
    ]
    
    var onCategoryDidSelect: ((Int) -> Void)?
}

extension NewsDataDisplayManager: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCategoryCell", for: indexPath) as! NewsCategoryCell
    }
}

extension NewsDataDisplayManager: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}
