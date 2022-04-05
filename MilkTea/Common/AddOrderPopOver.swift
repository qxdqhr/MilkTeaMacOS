//
//  AddPopOver.swift
//  MilkTea
//
//  Created by tiger on 2022/3/19.
//

import Cocoa
class AddOrderPopOver:NSPopover{
    init(viewController:NSViewController) {
        super.init()
        self.behavior = .transient
        self.animates = true
        self.contentViewController = viewController
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class AddOrderViewController:NSViewController,OrderViewControllerDelegate, NSPopoverDelegate{
    func sendTimeStringToBtn(timeString: String) {
        orderingTimeField.title = timeString
    }
    func sendJuicesStringToBtn(juiceString: String,juiceNum:Int,juicePrice:Double) {
        buyingJuiceField.title = juiceString
        juiceNumberField.stringValue = String(juiceNum)
        totalSellingPriceField.stringValue = String(juicePrice)
    }
    lazy var calendarPopOver = CalendarPopOver(viewController: CalendarPopOverViewController())
    lazy var juiceSelePopOver = OrderMutiSelePopOver(viewController: JuiceSeleTableViewController())
    // - MARK: - 控件
    lazy var customerNameLabel = NSTextField(labelWithString: "顾客名称")
    lazy var buyingJuiceLabel = NSTextField(labelWithString: "购买饮品")
    lazy var orderingTimeLabel = NSTextField(labelWithString: "下单时间")
    lazy var juiceNumberLabel = NSTextField(labelWithString: "本单饮品数量")
    lazy var totalSellingPriceLabel = NSTextField(labelWithString: "总售价")
    lazy var curEvaluateLabel = NSTextField(labelWithString: "本单评价")
    
    func clearValue(){
        customerNameField.stringValue = ""
        buyingJuiceField.title = "------"
        orderingTimeField.title = "------"
        juiceNumberField.stringValue = ""
        totalSellingPriceField.stringValue = ""
        curEvaluateField.stringValue = ""
    }
    lazy var customerNameField : NSTextField = {
        var ctrl = NSTextField()
        return ctrl
    }()
    lazy var buyingJuiceField : NSButton = {
        var ctrl = NSButton()
        ctrl.isBordered = false
        ctrl.title = "------"
        ctrl.target = self
        ctrl.action = #selector(tablePop)
        return ctrl
    }()
    lazy var orderingTimeField : NSButton = {
        var ctrl = NSButton()
        ctrl.isBordered = false
        ctrl.title = "------"
        ctrl.target = self
        ctrl.action = #selector(calendarPop)
        return ctrl
    }()

    lazy var juiceNumberField: NSTextField = {
        var ctrl = NSTextField(labelWithString: "")
        return ctrl
    }()
    lazy var totalSellingPriceField : NSTextField = {
        var ctrl = NSTextField(labelWithString: "")
        return ctrl
    }()
    lazy var curEvaluateField : NSComboBox = {
        var exportExcelType = NSComboBox()
        exportExcelType.usesDataSource = false
        exportExcelType.addItems(withObjectValues: [
            "好评",
            "中评",
            "差评"
        ])
        exportExcelType.isEditable = false
        return exportExcelType
    }()
    
    private lazy var addBtn: NSButton = {
        var ctrl = NSButton(title: "添加订单信息", target: self, action: #selector(addOrder))
        return ctrl
    }()
    // - MARK: - 生命周期
    override func loadView() {
        view = NSView(frame: NSRect(x: 200, y: 200, width: 400, height: 400))
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    // - MARK: - 重写代理函数
    
    // - MARK: - 重写其他函数
   
    // - MARK: - 事件函数
    @objc func calendarPop(_ sender:NSTextField){
      
        calendarPopOver.show(relativeTo: self.orderingTimeField.bounds, of: orderingTimeField, preferredEdge: .minX)
    }
    @objc func tablePop(_ sender:NSTextField){
        JuiceTypeNetwork.refresh()
        
        juiceSelePopOver.show(relativeTo: self.orderingTimeField.bounds, of: orderingTimeField, preferredEdge: .minX)
    }
    @objc func addOrder(_ sender:NSButton){
        let order = CustomerOrder.init(
            customerName: customerNameField.stringValue,
            buyingjuice: buyingJuiceField.title,
            orderingTime: orderingTimeField.title,
            juiceNumber: juiceNumberField.stringValue,
            totalSellingPrice: totalSellingPriceField.stringValue,
            curEvaluate: curEvaluateField.stringValue
        )
        order.userId = LoginUserInfo.getLoginUser().userId
        order.orderId = order.getOrderID()
        OrderNetwork.add(para: order)
    }
    // - MARK: - 加入视图以及布局
    func setupView(){
        view.addSubview(customerNameLabel)
        customerNameLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(50)
            $0.top.equalToSuperview().offset(20)
            $0.width.equalTo(150)
        }
        
        view.addSubview(customerNameField)
        customerNameField.snp.makeConstraints{
            $0.leading.equalTo(customerNameLabel.snp.trailing).offset(10)
            $0.centerY.equalTo(customerNameLabel)
            $0.width.equalTo(150)
        }
        //-----
        
        view.addSubview(buyingJuiceLabel)
        buyingJuiceLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(50)
            $0.top.equalTo(customerNameLabel.snp.bottom).offset(20)
            $0.width.equalTo(150)
        }
        
        view.addSubview(buyingJuiceField)
        buyingJuiceField.snp.makeConstraints{
            $0.leading.equalTo(buyingJuiceLabel.snp.trailing).offset(10)
            $0.centerY.equalTo(buyingJuiceLabel)
            $0.width.equalTo(150)
        }

        //-----
        
        view.addSubview(orderingTimeLabel)
        orderingTimeLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(50)
            $0.top.equalTo(buyingJuiceLabel.snp.bottom).offset(20)
            $0.width.equalTo(150)
        }
        
        view.addSubview(orderingTimeField)
        orderingTimeField.snp.makeConstraints{
            $0.leading.equalTo(orderingTimeLabel.snp.trailing).offset(10)
            $0.top.equalTo(orderingTimeLabel)
            $0.width.equalTo(150)
        }
        //-----
        
        view.addSubview(juiceNumberLabel)
        juiceNumberLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(50)
            $0.top.equalTo(orderingTimeField.snp.bottom).offset(20)
            $0.width.equalTo(150)
        }
        
        view.addSubview(juiceNumberField)
        juiceNumberField.snp.makeConstraints{
            $0.leading.equalTo(juiceNumberLabel.snp.trailing).offset(10)
            $0.centerY.equalTo(juiceNumberLabel)
            $0.width.equalTo(150)
        }
        //-----
        
        view.addSubview(totalSellingPriceLabel)
        totalSellingPriceLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(50)
            $0.top.equalTo(juiceNumberLabel.snp.bottom).offset(20)
            $0.width.equalTo(150)
        }
        
        view.addSubview(totalSellingPriceField)
        totalSellingPriceField.snp.makeConstraints{
            $0.leading.equalTo(totalSellingPriceLabel.snp.trailing).offset(10)
            $0.centerY.equalTo(totalSellingPriceLabel)
            $0.width.equalTo(150)
        }
        //-----
        
        view.addSubview(curEvaluateLabel)
        curEvaluateLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(50)
            $0.top.equalTo(totalSellingPriceLabel.snp.bottom).offset(20)
            $0.width.equalTo(150)
        }
        
        view.addSubview(curEvaluateField)
        curEvaluateField.snp.makeConstraints{
            $0.leading.equalTo(curEvaluateLabel.snp.trailing).offset(10)
            $0.centerY.equalTo(curEvaluateLabel)
            $0.width.equalTo(150)
        }
    
        view.addSubview(addBtn)
        addBtn.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(50)
            $0.top.equalTo(curEvaluateLabel.snp.bottom).offset(20)
            $0.width.equalTo(150)
        }
        
    }

}

