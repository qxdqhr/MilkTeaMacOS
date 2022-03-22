//
//  DefaultOwnerBarChart.swift
//  MilkTea
//
//  Created by tiger on 2022/3/11.
//

import AppKit
import Charts
class DefaultOwnerBarChart :NSViewController, ChartViewDelegate {
    // - MARK: - 数据
    let datas: [[Double]] = [
        [70, 32, 23, 35, 78, 15],
        [12, 22, 57, 8, 56, 28]
    ]


    func setDatas(){
        
        var dataSetMax: Double = 0
        let groupSpace = 0.4
        let barSpace = 0.01
        //柱子宽度（(barSpace + barWidth) * 系列数 + groupSpace = 1.00 -> interval per "group"）
        let barWidth = 0.29

        var dataSets = [BarChartDataSet]()
        for i in 0..<datas.count { //遍历两个数组
           var yValues = [BarChartDataEntry]()//创建 chart序对 的数组
           var set = BarChartDataSet()//创建序对集合
           
           let data = datas[i]
           for index in 0..<data.count {//遍历第一个数组
               let value = data[index]//获得第一个数据值
               dataSetMax = max(value, dataSetMax)
               yValues.append(BarChartDataEntry(x: Double(index), y: value))
               
               set = BarChartDataSet(entries: yValues, label: "第\(i)个图例")
               set.setColor(NSUIColor(red: CGFloat(arc4random() % 256) / 255.0, green: CGFloat(arc4random() % 256) / 255.0, blue: CGFloat(arc4random() % 256) / 255.0, alpha: 1.0))
               set.valueColors = [.red]
           }
           dataSets.append(set)
        }

        dataSetMax = (dataSetMax + dataSetMax * 0.0)
        dataSets[0].label = "月度总体收入数据"
        dataSets[1].label = "月度总体支出数据"
        overViewBarChartView.leftAxis.axisMaximum = dataSetMax
        overViewBarChartView.leftAxis.axisMinimum = 0

        let data = BarChartData(dataSets: dataSets)
        data.barWidth = barWidth
        data.groupBars(fromX: -0.5, groupSpace: groupSpace, barSpace: barSpace)

        overViewBarChartView.data = data

        overViewBarChartView.animate(xAxisDuration: 1)
        overViewBarChartView.setVisibleXRangeMaximum(3)
        //overViewBarChartView.fitBars = true
    }
    // - MARK: - 控件
    private lazy var overViewLbl: NSTextField = {
        var ctrl = NSTextField()
        ctrl.stringValue = "商户月度营销数据"
        ctrl.isBordered = false
        ctrl.isEditable = false
        ctrl.isSelectable = false
        ctrl.wantsLayer = true
        ctrl.backgroundColor = .clear
        return ctrl
    }()

    
    private lazy var overViewBarChartView: BarChartView = {
        var overViewBarChartView = BarChartView()
        overViewBarChartView.backgroundColor = NSColor.clear//背景色
        overViewBarChartView.drawValueAboveBarEnabled = true //数值显示在柱形图上面
        overViewBarChartView.drawBarShadowEnabled = false //是否绘制阴影
        overViewBarChartView.scaleYEnabled =  false //是否允许 Y轴缩放
        overViewBarChartView.scaleXEnabled =  false //是否允许 X轴缩放
        overViewBarChartView.doubleTapToZoomEnabled = false //是否允许双击放大
        overViewBarChartView.dragEnabled = true //是否允许拖拽
        overViewBarChartView.dragDecelerationEnabled = true //允许拖拽后具有惯性
        overViewBarChartView.dragDecelerationFrictionCoef = 0.9 //惯性效果的摩擦系数,越小惯性越不明显
        overViewBarChartView.delegate = self
        //设定 y轴
        var yAxis = overViewBarChartView.leftAxis
        yAxis.enabled = true
        yAxis.axisLineWidth = 1 //线宽
        yAxis.labelPosition = .outsideChart  //X轴显示位置,默认在上面
        yAxis.labelTextColor = NSColor.black//label文字颜色
        //设定 X轴
        var xAxis = overViewBarChartView.xAxis
        xAxis.enabled = true
        xAxis.axisLineWidth = 1 //X轴线宽
        xAxis.labelPosition = .bottom  //X轴显示位置,默认在上面
        xAxis.labelTextColor = NSColor.black//label文字颜色

        return overViewBarChartView
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
        
        view.addSubview(overViewBarChartView)
        overViewBarChartView.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalTo(overViewLbl.snp.bottom)
            $0.bottom.equalToSuperview()

        }
        setDatas()
    }
}
