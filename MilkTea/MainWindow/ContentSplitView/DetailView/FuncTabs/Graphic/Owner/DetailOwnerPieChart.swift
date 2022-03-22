//
//  DetailOwnerPieChart.swift
//  MilkTea
//
//  Created by tiger on 2022/3/11.
//

import AppKit
import Charts
class DetailOwnerPieChart :NSViewController,ChartViewDelegate {
    // - MARK: - 数据
    let datas: [Double] = [
        70, 32, 23, 35, 78
    ]


    func setDatas(){
        var values = [PieChartDataEntry]()
        for i in 0..<datas.count {
            values.append(PieChartDataEntry(value: datas[i], label: "\(datas[i])aaa"))
        }
        let dataSet = PieChartDataSet(entries: values, label: "图例")
        dataSet.colors = ChartColorTemplates.vordiplom()
        let data = PieChartData(dataSet: dataSet)

        pieChartView.data = data
        pieChartView.animate(xAxisDuration: 1)
    }
    // - MARK: - 控件
    private lazy var overViewLbl: NSTextField = {
        var ctrl = NSTextField()
        ctrl.stringValue = "商户月度营销详细数据"
        ctrl.isBordered = false
        ctrl.isEditable = false
        ctrl.isSelectable = false
        ctrl.wantsLayer = true
        ctrl.backgroundColor = .clear
        return ctrl
    }()

    
    private lazy var pieChartView: PieChartView = {
        var pieChartView = PieChartView()
        pieChartView.backgroundColor = NSColor.clear//背景色
        pieChartView.delegate = self
    
        return pieChartView
    }()
    

    // - MARK: - 生命周期
    override func loadView() {
        view = NSView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    // - MARK: - 重写代理函数
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
    // - MARK: - 重写其他函数
    
    // - MARK: - 事件函数
    
    // - MARK: - 加入视图以及布局
    func setupView(){
        view.addSubview(overViewLbl)
        overViewLbl.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalTo(30)
            $0.trailing.equalToSuperview()

        }
        
        view.addSubview(pieChartView)
        pieChartView.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalTo(overViewLbl.snp.bottom)
            $0.bottom.equalToSuperview()

        }
        setDatas()
    }
}

