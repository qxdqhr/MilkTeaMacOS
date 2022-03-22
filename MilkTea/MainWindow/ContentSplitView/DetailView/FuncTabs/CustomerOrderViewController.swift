//
//  UserOrderViewController.swift
//  MilkTea
//
//  Created by tiger on 2022/2/24.
//

import Cocoa
extension CustomerOrderViewController :NSTableViewDataSource{
    func numberOfRows(in tableView: NSTableView) -> Int {
        return userInfoDataArr.count
    }

}
extension CustomerOrderViewController :NSTableViewDelegate{
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        //获取当前列的标识符
        let key = (tableColumn?.identifier)!
        //创建单元格cell视图
        var view = tableView.makeView(withIdentifier: key, owner: self)
        if (view == nil){
            view = NSView()
        }
        //判断当前列的标识符是哪一列
        if(key.rawValue != "操作"){
            let item = userInfoDataArr[row]
            let textField = NSTextField(labelWithString: item[key.rawValue] as! String )
            view?.addSubview(textField)
        }else{
            var modifyBtn = NSButton(title: "修改", target: self, action: #selector(popoverAddInfoWnd))
            modifyBtn.isBordered = false
            modifyBtn.tag = row
            var deleteBtn = NSButton(title: "删除", target: self, action: #selector(popoverAddInfoWnd))
            deleteBtn.isBordered = false
            deleteBtn.tag = row

            view?.addSubview(modifyBtn)
            view?.addSubview(deleteBtn)
            modifyBtn.snp.makeConstraints{
                $0.leading.equalToSuperview()
            }
            deleteBtn.snp.makeConstraints{
                $0.leading.equalTo(modifyBtn.snp.trailing)
            }
        }
        return view
    }
}

class CustomerOrderViewController: NSViewController {
    // - MARK: - 数据
    var userInfoDataArr : [CustomerOrder] = [
        CustomerOrder(customerName: "aaa", buyingjuice: "aaa", orderingTime: "111", juiceNumber: "1", totalSellingPrice: "11", curEvaluate: "aaa")
        ]

    // - MARK: - 控件
    private lazy var addInfoBtn = NSButton(title: "添加顾客订单信息", target: self, action: #selector(popoverAddInfoWnd))
    private lazy var queryInfoBtn = NSButton(title: "查询顾客订单信息", target: self, action: #selector(popoverQueryInfoWnd))
    private lazy var refreshBtn = NSButton(title: "刷新", target: self, action: #selector(refresh))
    private lazy var popover1 = QueryPopOver(viewController: QueryViewController())
    lazy var popoverAddOrder = AddOrderPopOver(viewController: AddOrderViewController())
    private lazy var userOrderTable : NSTableView = {
        var userInfoTable = NSTableView()
        userInfoTable.delegate = self
        userInfoTable.dataSource = self
        userInfoTable.usesAlternatingRowBackgroundColors = true
        userInfoTable.columnAutoresizingStyle = .uniformColumnAutoresizingStyle
        userInfoTable.allowsColumnResizing = false
        userInfoTable.allowsColumnReordering = false
        return userInfoTable
    }()
    private lazy var scroll: NSScrollView = {
        var ctrl  = NSScrollView()
        ctrl.documentView = userOrderTable
        return ctrl
    }()
    // - MARK: - 生命周期
    override func loadView() {
        view = NSView()
        for property in CustomerOrder.getUIName(){
            print(property)
            self.userOrderTable.addTableColumn(getColumn(title: property))
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    // - MARK: - 重写代理函数
    
    // - MARK: - 其他函数
    func getColumn(title:String) ->NSTableColumn{
        var column1 = NSTableColumn()
        column1.headerCell.type = .textCellType
        column1.headerCell.alignment = .center
        column1.headerCell.state = .on
        column1.identifier = NSUserInterfaceItemIdentifier(title)
        column1.title = title
        print(column1.identifier)
        return column1
    }
    // - MARK: - 事件函数
    @objc func popoverAddInfoWnd(_ sender:NSButton){
        (popoverAddOrder.contentViewController as!AddOrderViewController).clearValue()
        popoverAddOrder.show(relativeTo: self.addInfoBtn.bounds, of: self.addInfoBtn, preferredEdge: .maxX)
    }
    @objc func popoverQueryInfoWnd(_ sender:NSButton){
        (popover1.contentViewController as! QueryViewController).getCallClsPropertyName(clsName: CustomerOrder.self)
        popover1.show(relativeTo: self.queryInfoBtn.bounds, of: self.queryInfoBtn, preferredEdge: .maxX)
        
    }
    @objc func refresh(_ sender:NSButton){

        
    }
    // - MARK: - 加入视图以及布局
    func setupView(){
        view.addSubview(addInfoBtn)
        addInfoBtn.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalTo(30)
        }
        
        view.addSubview(refreshBtn)
        refreshBtn.snp.makeConstraints{
            $0.leading.equalTo(addInfoBtn.snp.trailing)
            $0.top.equalToSuperview()
            $0.height.equalTo(30)
        }
        view.addSubview(queryInfoBtn)
        queryInfoBtn.snp.makeConstraints{
            $0.leading.equalTo(refreshBtn.snp.trailing)
            $0.top.equalToSuperview()
            $0.height.equalTo(30)
        }
        view.addSubview(scroll)
        scroll.snp.makeConstraints{
            $0.trailing.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.top.equalTo(queryInfoBtn.snp.bottom)
            $0.bottom.equalToSuperview()
        }
        
    }
    
}
