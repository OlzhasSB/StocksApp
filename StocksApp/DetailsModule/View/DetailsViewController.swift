//
//  DetailsViewController.swift
//  StocksApp
//
//  Created by Aida Moldaly on 26.07.2022.
//

import UIKit
import HGPlaceholders
import SkeletonView
import Charts

protocol DetailsViewInput: AnyObject {
    func hundleObtainedFilter(_ filter: [FilterEntity])
}

protocol DetailsViewOutput {
    func didLoadView()
    func didSelectFilterCell(with filter: String)
}

class DetailsViewController: UIViewController {

    var output: DetailsViewOutput?
    var dataDisplayManager: DetailsDataDisplayManager?
    var lineChart = LineChartView()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "Details"
        label.font = UIFont.boldSystemFont(ofSize: 30.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmented = UISegmentedControl (items: ["Line","Candle"])
        
        segmented.backgroundColor = UIColor.systemGray6

        segmented.selectedSegmentTintColor = UIColor.black


        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        segmented.setTitleTextAttributes(titleTextAttributes, for:.normal)

        let titleTextAttributes1 = [NSAttributedString.Key.foregroundColor: UIColor.white]
        segmented.setTitleTextAttributes(titleTextAttributes1, for:.selected)
        segmented.frame.size.height = 50.0
        
        let font = UIFont.systemFont(ofSize: 16)
        segmented.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)

        segmented.frame = CGRect()
        segmented.selectedSegmentIndex = 0

        segmented.addTarget(self, action: #selector(segmentAction(_:)), for: .valueChanged)
        return segmented
    }()
    
    private let filterCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 10)
        layout.minimumLineSpacing = 10
    
        var collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: "FilterCollectionViewCell")
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpCollectionViews()
        makeConstraints()
        setUPChartVuew()
        output?.didLoadView()
    }
    
    func setUPChartVuew() {
        lineChart.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        lineChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width)
//        lineChart.center = view.center
//        view.addSubview(lineChart)
        
        var entities = [ChartDataEntry]()
        
        for x in 0..<10 {
            entities.append(ChartDataEntry(x: Double(x), y: Double(x)))
        }
        let set = LineChartDataSet(entries: entities)
        set.colors = ChartColorTemplates.material()
        
        let data = LineChartData(dataSet: set)
        
        lineChart.data = data
        
    }
    
    @objc
    func segmentAction(_ sender: UISegmentedControl) {
        
//        let index = sender.selectedSegmentIndex
        
//        switch index {
//        case 0:
//            view.backgroundColor = .systemMint
//        case 1:
//            view.backgroundColor = .systemPink
//        default:
//            break
//        }
    }
    
    private func setUpCollectionViews() {
        
        dataDisplayManager?.onFilterDidSelect = { [ weak self] filter in
            self?.output?.didSelectFilterCell(with: filter)
        }
        
        filterCollectionView.delegate = dataDisplayManager
        filterCollectionView.dataSource = dataDisplayManager
        
    }
    
    private func makeConstraints() {
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(-15)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(50)
        }
        
        view.addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(115)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-115)
            make.height.equalTo(35)
        }
        
        view.addSubview(lineChart)
        lineChart.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(20)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(400)
        }
        
        view.addSubview(filterCollectionView)
        filterCollectionView.snp.makeConstraints { make in
            make.top.equalTo(lineChart.snp.bottom).offset(20)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
    }
}

extension DetailsViewController: DetailsViewInput {
    
    func hundleObtainedFilter(_ filter: [FilterEntity]) {
        dataDisplayManager?.filter = filter
        filterCollectionView.reloadData()
    }
}

extension DetailsViewController: ChartViewDelegate {
    
}
