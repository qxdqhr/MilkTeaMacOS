//
//  BaseQueryPopOver.swift
//  MilkTea
//
//  Created by tiger on 2022/3/13.
//

import Cocoa

class QueryPopOver:NSPopover{
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
typealias queryAction = (_ sender:NSButton) -> Void

class QueryViewController:NSViewController{
    var queryAction :queryAction = {btn in };
    // - MARK: - 控件
    private lazy var queryNameLabel: NSTextField = {
        var ctrl = NSTextField(labelWithString: "查询属性名称")
        return ctrl
    }()

    lazy var queryName : NSComboBox = {
        var queryName = NSComboBox()
        queryName.isEditable = false
        return queryName
    }()

    private lazy var queryValueLabel: NSTextField = {
        var ctrl = NSTextField(labelWithString: "查询属性值")
        return ctrl
    }()
    
    
    lazy var queryValue: NSTextField = {
        var ctrl = NSTextField()
        return ctrl
    }()
    
    private lazy var queryBtn: NSButton = {
        var ctrl = NSButton(title: "查询", target: self, action:  #selector(query))
        return ctrl
    }()
    // - MARK: - 生命周期
    override func loadView() {
        view = NSView(frame: NSRect(x: 200, y: 200, width: 400, height: 200))
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    // - MARK: - 重写代理函数
    func clearValue(){
        queryName.stringValue = ""
        queryValue.stringValue = ""
    }
    // - MARK: - 重写其他函数
    func getCallClsPropertyName(clsName:BaseModel.Type){
        queryName.removeAllItems()
        queryName.addItems(withObjectValues: clsName.getUIName())
        queryName.removeItem(withObjectValue: "操作")
        queryName.removeItem(withObjectValue: "分店账号")
        queryName.removeItem(withObjectValue: "主键")

    }

    // - MARK: - 事件函数
    @objc func query(_ sender:NSButton){
        self.queryAction(sender)
    }
    
    func sendQueryAction(act:@escaping queryAction){
        self.queryAction = act
    }
    // - MARK: - 加入视图以及布局
    func setupView(){
        view.addSubview(queryNameLabel)
        queryNameLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(50)
            $0.top.equalToSuperview().offset(20)
            $0.width.equalTo(150)
        }
        
        view.addSubview(queryName)
        queryName.snp.makeConstraints{
            $0.leading.equalTo(queryNameLabel.snp.trailing).offset(10)
            $0.centerY.equalTo(queryNameLabel)
            $0.width.equalTo(150)
        }
        
        view.addSubview(queryValueLabel)
        queryValueLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(50)
            $0.top.equalTo(queryNameLabel.snp.bottom).offset(20)
            $0.width.equalTo(150)
        }
        
        view.addSubview(queryValue)
        queryValue.snp.makeConstraints{
            $0.leading.equalTo(queryValueLabel.snp.trailing).offset(10)
            $0.centerY.equalTo(queryValueLabel)
            $0.width.equalTo(150)
        }
        
        view.addSubview(queryBtn)
        queryBtn.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(50)
            $0.top.equalTo(queryValueLabel.snp.bottom).offset(20)
            $0.width.equalTo(150)
        }
        
    }

}
