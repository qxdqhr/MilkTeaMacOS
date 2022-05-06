//
//  DefaultExOwnerLineChart.swift
//  MilkTea
//
//  Created by tiger on 2022/3/11.
//

import AppKit
import Charts

class DefaultExOwnerLineChart :NSViewController,ChartViewDelegate {
    // - MARK: - 数据
 
    var datas: [[Double]] = []
    var inexDatas =  (((WindowManager.shared.MainWnd.contentViewController as! MainMenuViewController)
                            .contentViewControllerItem.viewController as! ContentSplitViewController)
                        .detailViewController.tabViewItems[6].viewController as! ExOwnerInputExpensesViewController).userInfoDataArr
    var inArr:[String:Double] = [:]
    var exArr:[String:Double] = [:]
    var dataSetMax: Double = 0
    let groupSpace = 0.4
    let barSpace = 0.01
    //柱子宽度（(barSpace + barWidth) * 系列数 + groupSpace = 1.00 -> interval per "group"）
    let barWidth = 0.29

    var dataSets = [LineChartDataSet]()
    
    override func viewWillAppear() {

        self.inexDatas = (((WindowManager.shared.MainWnd.contentViewController as! MainMenuViewController)
                            .contentViewControllerItem.viewController as! ContentSplitViewController)
                        .detailViewController.tabViewItems[6].viewController as! ExOwnerInputExpensesViewController).userInfoDataArr
        self.datas.removeAll()
        self.inArr.removeAll()
        self.exArr.removeAll()

        for (_,inex) in inexDatas.enumerated(){
            
            if(inArr.keys.contains(inex.month)){
                inArr[inex.month] = (Double( inArr[inex.month] ?? 0.00) ) + (Double(inex.totalIncome) ?? 0.00)
                exArr[inex.month] = (Double( exArr[inex.month] ?? 0.00) ) + (Double(inex.totalExpence) ?? 0.00)
                continue
            }
            inArr[inex.month] = (Double(inex.totalIncome) ?? 0.00)
            exArr[inex.month] = (Double(inex.totalExpence) ?? 0.00)
        }
        var inValues = inArr.sorted(by: {$0.0<$1.0})
        var exValues = exArr.sorted(by: {$0.0<$1.0})
        
        var inarr:[Double] = [0]
        var exarr:[Double] = [0]
        for ele in inValues{
            inarr.append(ele.value)
        }
        for ele in exValues{
            exarr.append(ele.value)
        }
        datas.append(inarr)
        datas.append(exarr)

        
        self.setDatas()
    }
    func setDatas(){
        dataSets.removeAll()
     
        for (i,val) in datas.enumerated() { //遍历两个数组
           var yValues = [ChartDataEntry]()//创建 chart序对 的数组
           var set = LineChartDataSet()//创建序对集合
           
           let data = val
            for (index,value) in data.enumerated() {//遍历第一个数组
               dataSetMax = max(value, dataSetMax)
               yValues.append(ChartDataEntry(x: Double(index), y: value))
               
               set = LineChartDataSet(entries: yValues, label: "第\(index)个图例")
               set.setColor(NSUIColor(red: CGFloat(arc4random() % 256) / 255.0, green: CGFloat(arc4random() % 256) / 255.0, blue: CGFloat(arc4random() % 256) / 255.0, alpha: 1.0))
               set.valueColors = [.red]
           }
           dataSets.append(set)
        }

        dataSetMax = (dataSetMax + dataSetMax * 0.0)
        dataSets[0].label = "月度总体收入数据"
        dataSets[1].label = "月度总体支出数据"
        overViewLineChartView.leftAxis.axisMaximum = dataSetMax+50
        overViewLineChartView.leftAxis.axisMinimum = 0
        overViewLineChartView.xAxis.axisMinimum = 0
        overViewLineChartView.xAxis.axisMaximum = dataSetMax+50
        let data = LineChartData(dataSets: dataSets)

        overViewLineChartView.data = data

        overViewLineChartView.animate(xAxisDuration: 1)
        overViewLineChartView.setVisibleXRangeMaximum(3)
        //overViewLineChartView.fitLines = true
    }
    // - MARK: - 控件
    private lazy var overViewLbl: NSTextField = {
        var ctrl = NSTextField()
        ctrl.stringValue = "经销商月度营销数据"
        ctrl.isBordered = false
        ctrl.isEditable = false
        ctrl.isSelectable = false
        ctrl.wantsLayer = true
        ctrl.backgroundColor = .clear
        return ctrl
    }()
    
    private lazy var overViewLineChartView: LineChartView = {
        var overViewLineChartView = LineChartView()
        overViewLineChartView.backgroundColor = NSColor.clear//背景色
        overViewLineChartView.scaleYEnabled =  false //是否允许 Y轴缩放
        overViewLineChartView.scaleXEnabled =  false //是否允许 X轴缩放
        overViewLineChartView.doubleTapToZoomEnabled = false //是否允许双击放大
        overViewLineChartView.dragEnabled = true //是否允许拖拽
        overViewLineChartView.dragDecelerationEnabled = true //允许拖拽后具有惯性
        overViewLineChartView.dragDecelerationFrictionCoef = 0.9 //惯性效果的摩擦系数,越小惯性越不明显
        overViewLineChartView.delegate = self
        //不显示右侧 Y轴
        overViewLineChartView.rightAxis.enabled = false
        //设定 y轴
        var yAxis = overViewLineChartView.leftAxis
        yAxis.enabled = true
        yAxis.forceLabelsEnabled = false
        yAxis.inverted = false
        yAxis.axisLineWidth = 1 //线宽
        yAxis.labelPosition = .outsideChart  //轴显示位置,默认在上面
        yAxis.labelTextColor = NSColor.black//label文字颜色
        //设定 X轴
        var xAxis = overViewLineChartView.xAxis
        xAxis.enabled = true
        xAxis.granularityEnabled = true//设置重复的值不显示
        xAxis.labelPosition = .bottom//设置x轴数据在底部
        xAxis.gridColor = .clear
        xAxis.labelTextColor = .black//文字颜色
        xAxis.axisLineColor = .gray
        xAxis.drawGridLinesEnabled = false
     
        overViewLineChartView.maxVisibleCount = 999
//        xAxis.axisLineWidth = 1 //X轴线宽
//        xAxis.labelPosition = .bottom  //X轴显示位置,默认在上面
//        xAxis.labelTextColor = NSColor.black//label文字颜色
        return overViewLineChartView
    }()
    

    // - MARK: - 生命周期
    override func loadView() {
        view = NSView()
        var xAxisArr = Set<String>()
        xAxisArr.insert("0000-00")

        for (_,inex) in inexDatas.enumerated(){
//            inArr.append(Double(inex.totalIncome) ?? 0.00)
//            exArr.append(Double(inex.totalExpence) ?? 0.00)
            xAxisArr.insert(inex.month)
        }
//        datas.append(inArr)
//        datas.append(exArr)
        var arr = Array(xAxisArr)
        arr.sort{
            (left:String,right:String) -> Bool in
            left < right
        }
        self.overViewLineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values:arr )
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
//    // - MARK: - 重写代理函数
//    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
//        var month = ""
//        for (_,inex) in inexDatas.enumerated(){
//            if Double(inex.totalIncome) == entry.y {
//                month = inex.month
//            }
//        }
//    }
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
        
        view.addSubview(overViewLineChartView)
        overViewLineChartView.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalTo(overViewLbl.snp.bottom)
            $0.bottom.equalToSuperview()

        }
    }
}
