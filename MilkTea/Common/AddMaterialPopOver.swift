//
//  AddMaterialPopOver.swift
//  MilkTea
//
//  Created by tiger on 2022/3/20.
//

import Cocoa
class AddMaterialPopOver:NSPopover{
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
class AddMaterialViewController:NSViewController, OrderViewControllerDelegate,NSPopoverDelegate{
    func sendTimeStringToBtn(timeString: String) {
        materialMonthBuyingTimeField.title = timeString
    }
    lazy var calendarPopOver = CalendarPopOver(viewController: CalendarPopOverViewController())
    // - MARK: - 控件
    lazy var materialNameLabel = NSTextField(labelWithString: "原料名称")
    lazy var materialNumberLabel = NSTextField(labelWithString: "购入数量")
    lazy var materialPerPriceLabel = NSTextField(labelWithString: "原料单价")
    lazy var materialMonthBuyingTimeLabel = NSTextField(labelWithString: "购入时间")
    lazy var materialMonthTotalPriceLabel = NSTextField(labelWithString: "购入成本")
    
    func clearValue(){
        materialNameField.stringValue = ""
        materialNumberField.stringValue = ""
        materialPerPriceField.stringValue = ""
        materialMonthBuyingTimeField.title = "------"
        materialMonthTotalPriceField.stringValue = ""
    }
    lazy var materialNameField : NSTextField = {
        var ctrl = NSTextField()
        return ctrl
    }()

    lazy var materialNumberField: NSTextField = {
        var ctrl = NSTextField()
        return ctrl
    }()
    lazy var materialPerPriceField : NSTextField = {
        var ctrl = NSTextField()
        return ctrl
        
    }()
    
    lazy var materialMonthBuyingTimeField : NSButton = {
        var ctrl = NSButton()
        ctrl.isBordered = false
        ctrl.title = "------"
        ctrl.target = self
        ctrl.action = #selector(calendarPop)
        return ctrl
    }()
    lazy var materialMonthTotalPriceField : NSTextField = {
        var ctrl = NSTextField(labelWithString: "")
        return ctrl
    }()
    
    private lazy var addBtn: NSButton = {
        var ctrl = NSButton(title: "添加原料购入信息", target: self, action: #selector(addMaterial))
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
  
        calendarPopOver.show(relativeTo: self.materialMonthBuyingTimeField.bounds, of: materialMonthBuyingTimeField, preferredEdge:.minX)
    }
 
    @objc func addMaterial(_ sender:NSButton){
        let num = Double(materialNumberField.stringValue) ?? 0.0
        let perprice = Double(materialPerPriceField.stringValue) ?? 0.0
        
        materialMonthTotalPriceField.stringValue =  String( format:"%.2f",num * perprice)
        
        
        if  materialNameField.stringValue == "" ||
            materialNumberField.stringValue == "" ||
            materialPerPriceField.stringValue == "" ||
            materialMonthBuyingTimeField.title == "" ||
            materialMonthTotalPriceField.stringValue == "" {
            MsgHelper.showMsg(message: "值不合法")
            clearValue()
        }

        
        let material = JuiceMaterial.init(
            juiceMaterialName: materialNameField.stringValue,
            materialNumber: materialNumberField.stringValue,
            materialPerPrice: materialPerPriceField.stringValue,
            materialMonthBuyingTime: materialMonthBuyingTimeField.title,
            materialMonthTotalPrice: materialMonthTotalPriceField.stringValue
        )
        material.id = material.getMaterialID()
        material.userId = LoginUserInfo.getLoginUser().userId
        MaterialNetwork.add(para: material)
    }
    // - MARK: - 加入视图以及布局
    func setupView(){
        view.addSubview(materialNameLabel)
        materialNameLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(50)
            $0.top.equalToSuperview().offset(20)
            $0.width.equalTo(150)
        }
        
        view.addSubview(materialNameField)
        materialNameField.snp.makeConstraints{
            $0.leading.equalTo(materialNameLabel.snp.trailing).offset(10)
            $0.centerY.equalTo(materialNameLabel)
            $0.width.equalTo(150)
        }
        //-----
        
        view.addSubview(materialNumberLabel)
        materialNumberLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(50)
            $0.top.equalTo(materialNameLabel.snp.bottom).offset(20)
            $0.width.equalTo(150)
        }
        
        view.addSubview(materialNumberField)
        materialNumberField.snp.makeConstraints{
            $0.leading.equalTo(materialNumberLabel.snp.trailing).offset(10)
            $0.centerY.equalTo(materialNumberLabel)
            $0.width.equalTo(150)
        }

        //-----
        
        view.addSubview(materialPerPriceLabel)
        materialPerPriceLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(50)
            $0.top.equalTo(materialNumberLabel.snp.bottom).offset(20)
            $0.width.equalTo(150)
        }
        
        view.addSubview(materialPerPriceField)
        materialPerPriceField.snp.makeConstraints{
            $0.leading.equalTo(materialPerPriceLabel.snp.trailing).offset(10)
            $0.top.equalTo(materialPerPriceLabel)
            $0.width.equalTo(150)
        }
        //-----
        
        view.addSubview(materialMonthBuyingTimeLabel)
        materialMonthBuyingTimeLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(50)
            $0.top.equalTo(materialPerPriceField.snp.bottom).offset(20)
            $0.width.equalTo(150)
        }
        
        view.addSubview(materialMonthBuyingTimeField)
        materialMonthBuyingTimeField.snp.makeConstraints{
            $0.leading.equalTo(materialMonthBuyingTimeLabel.snp.trailing).offset(10)
            $0.centerY.equalTo(materialMonthBuyingTimeLabel)
            $0.width.equalTo(150)
        }
        //-----
        
        view.addSubview(materialMonthTotalPriceLabel)
        materialMonthTotalPriceLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(50)
            $0.top.equalTo(materialMonthBuyingTimeLabel.snp.bottom).offset(20)
            $0.width.equalTo(150)
        }
        
        view.addSubview(materialMonthTotalPriceField)
        materialMonthTotalPriceField.snp.makeConstraints{
            $0.leading.equalTo(materialMonthTotalPriceLabel.snp.trailing).offset(10)
            $0.centerY.equalTo(materialMonthTotalPriceLabel)
            $0.width.equalTo(150)
        }
        //-----

        view.addSubview(addBtn)
        addBtn.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(50)
            $0.top.equalTo(materialMonthTotalPriceLabel.snp.bottom).offset(20)
            $0.width.equalTo(150)
        }
        
    }}

