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
    
    private var candleStickData: [CandleStick] = []
    
    let tickerLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "AAPL"
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.text = "$123.42"
        label.isSkeletonable = true
        return label
    }()
    
    let priceChangeLabel: UILabel = {
        let label = UILabel()
        label.text = "+$0.12 (1,15%)"
        label.textColor = .systemGreen
        label.font = UIFont.systemFont(ofSize: 12)
        label.isSkeletonable = true
        return label
    }()
    
    lazy var lineChart: LineChartView = {
        let chartView = LineChartView()
    
        chartView.leftAxis.enabled = false
        chartView.xAxis.drawGridLinesEnabled = false
        
        let yAxis = chartView.rightAxis
        yAxis.setLabelCount(6, force: false)
        yAxis.labelTextColor = .black
        yAxis.labelPosition = .outsideChart
        yAxis.drawGridLinesEnabled = false
        
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelFont = .boldSystemFont(ofSize: 12)
        chartView.xAxis.setLabelCount(6, force: false)
        chartView.xAxis.labelTextColor = .black
        
        chartView.animate(xAxisDuration: 1.0)
        chartView.legend.enabled = false
//        chartView.isUserInteractionEnabled = true
        

        return chartView
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
    
    let companyInfo: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "About company"
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let country: UILabel = {
        let label = UILabel()
        label.text = "Country: US"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let exchange: UILabel = {
        let label = UILabel()
        label.text = "Exchange: NASDAQ/NMS (GLOBAL MARKET)"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let ipo: UILabel = {
        let label = UILabel()
        label.text = "IPO: 1980-12-12"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let finnhubIndustry: UILabel = {
        let label = UILabel()
        label.text = "Industry: Technology"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let weburl: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray2
        label.text = "https://www.apple.com"
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpCollectionViews()
        makeConstraints()
        setUPChartVuew()
        output?.didLoadView()
        title = "China Fund Inc"
    }
    
    func setUPChartVuew() {
        lineChart.delegate = self
    }
    
    var entities: [ChartDataEntry] = [
        ChartDataEntry(x: 1572566400, y: 129.4534),
        ChartDataEntry(x: 1572825600, y: 131.4974),
        ChartDataEntry(x: 1572912000, y: 131.7076),
        ChartDataEntry(x: 1572998400, y: 132.5577),
        ChartDataEntry(x: 1573084800, y: 131.5165),
        ChartDataEntry(x: 1573171200, y: 131.4401),
        ChartDataEntry(x: 1573430400, y: 129.3961),
        ChartDataEntry(x: 1573516800, y: 129.5107),
        ChartDataEntry(x: 1573603200, y: 128.4504),
        ChartDataEntry(x: 1573776000, y: 128.374),
        ChartDataEntry(x: 1574035200, y: 128.2881),
        ChartDataEntry(x: 1574121600, y: 128.4887),
        ChartDataEntry(x: 1574208000, y: 127.2278),
        ChartDataEntry(x: 1574294400, y: 127.8392),
        ChartDataEntry(x: 1574380800, y: 128.3167),
        ChartDataEntry(x: 1574640000, y: 129.8736),
        ChartDataEntry(x: 1574726400, y: 129.0331),
        ChartDataEntry(x: 1574812800, y: 127.7723),
        ChartDataEntry(x: 1574985600, y: 128.4218),
    ]
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let set = LineChartDataSet(entries: entities)
        set.colors = ChartColorTemplates.material()
        set.drawCirclesEnabled = false
        set.mode = .cubicBezier
        set.lineWidth = 3
        set.drawIconsEnabled = false
        set.drawValuesEnabled = false

        set.drawHorizontalHighlightIndicatorEnabled = false
        set.drawVerticalHighlightIndicatorEnabled = false
        
        let data = LineChartData(dataSet: set)
        data.setDrawValues(false)
        lineChart.data = data
        lineChart.setVisibleXRangeMaximum(1000000)
        lineChart.moveViewToX(Double(entities.count - 1))
        
    }
    
    @objc
    func segmentAction(_ sender: UISegmentedControl) {
        
        let index = sender.selectedSegmentIndex
        
        switch index {
        case 0:
            view.backgroundColor = .systemMint
        case 1:
            view.backgroundColor = .systemPink
        default:
            break
        }
    }
    
    private func setUpCollectionViews() {
        
        dataDisplayManager?.onFilterDidSelect = { [ weak self] filter in
            self?.output?.didSelectFilterCell(with: filter)
        }
        filterCollectionView.delegate = dataDisplayManager
        filterCollectionView.dataSource = dataDisplayManager
    }
    
    private func makeConstraints() {
        
        view.addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(35)
        }
        
        view.addSubview(tickerLabel)
        tickerLabel.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(8)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        view.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(tickerLabel.snp.bottom).offset(2)
            make.left.equalTo(tickerLabel.snp.left)
        }
        
        view.addSubview(priceChangeLabel)
        priceChangeLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(5)
            make.left.equalTo(tickerLabel.snp.left)
        }
        
        view.addSubview(lineChart)
        lineChart.snp.makeConstraints { make in
            make.top.equalTo(priceChangeLabel.snp.bottom).offset(-10)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
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
        
        view.addSubview(companyInfo)
        companyInfo.snp.makeConstraints { make in
            make.top.equalTo(filterCollectionView.snp.bottom).offset(15)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        view.addSubview(country)
        country.snp.makeConstraints { make in
            make.top.equalTo(companyInfo.snp.bottom).offset(10)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide)
        }

        view.addSubview(exchange)
        exchange.snp.makeConstraints { make in
            make.top.equalTo(country.snp.bottom).offset(5)
            make.left.equalTo(country.snp.left)
            make.right.equalTo(country.snp.right)
        }
        
        view.addSubview(ipo)
        ipo.snp.makeConstraints { make in
            make.top.equalTo(exchange.snp.bottom).offset(5)
            make.left.equalTo(country.snp.left)
            make.right.equalTo(country.snp.right)
        }
        
        view.addSubview(finnhubIndustry)
        finnhubIndustry.snp.makeConstraints { make in
            make.top.equalTo(ipo.snp.bottom).offset(5)
            make.left.equalTo(country.snp.left)
            make.right.equalTo(country.snp.right)
        }

        view.addSubview(weburl)
        weburl.snp.makeConstraints { make in
            make.top.equalTo(finnhubIndustry.snp.bottom).offset(5)
            make.left.equalTo(country.snp.left)
            make.right.equalTo(country.snp.right)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-25)
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
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
}

