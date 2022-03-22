//
//  UserInfoViewController.swift
//  MilkTea
//
//  Created by tiger on 2022/2/22.
//

import Cocoa
extension CustomerInfoViewController :NSTableViewDataSource{
    func numberOfRows(in tableView: NSTableView) -> Int {
        return userInfoDataArr.count
    }

}
extension CustomerInfoViewController :NSTableViewDelegate{
 
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
            let textField = NSTextField(labelWithString: item[key.rawValue] )
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
class CustomerInfoViewController: NSViewController {
    // - MARK: - 数据
    var userInfoDataArr : [CustomerInfo] = [
        CustomerInfo(customerName: "aa", buyingTime: "aa", recentEvaluate: "啊啊"),
        CustomerInfo(customerName: "a1", buyingTime: "aa", recentEvaluate: "啊啊"),
        CustomerInfo(customerName: "aa", buyingTime: "ab", recentEvaluate: "啊啊")
        ]

    // - MARK: - 控件
    private lazy var addInfoBtn = NSButton(title: "添加顾客信息", target: self, action: #selector(popoverAddInfoWnd))
    private lazy var queryInfoBtn = NSButton(title: "查询顾客信息", target: self, action: #selector(popoverAddInfoWnd))
    private lazy var refreshBtn = NSButton(title: "刷新", target: self, action: #selector(popoverAddInfoWnd))
    private lazy var popover1 = QueryPopOver(viewController: QueryViewController())
    private lazy var userInfoTable : NSTableView = {
        var userInfoTable = NSTableView()
        userInfoTable.delegate = self
        userInfoTable.dataSource = self
        userInfoTable.usesAlternatingRowBackgroundColors = true
        userInfoTable.columnAutoresizingStyle = .uniformColumnAutoresizingStyle
        userInfoTable.allowsColumnResizing = false
        userInfoTable.allowsColumnReordering = false
        
        return userInfoTable
    }()
    lazy var scroll: NSScrollView = {
        var ctrl  = NSScrollView()
        ctrl.documentView = userInfoTable
        return ctrl
    }()
    // - MARK: - 生命周期
    override func loadView() {
        view = NSView()
        for property in CustomerInfo.getUIName(){
            self.userInfoTable.addTableColumn(getColumn(title: property))
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    // - MARK: - 事件函数
    @objc func popoverAddInfoWnd(_ sender:NSButton){
        (popover1.contentViewController as! QueryViewController).getCallClsPropertyName(clsName: CustomerInfo.self)
        popover1.show(relativeTo: self.queryInfoBtn.bounds, of: self.queryInfoBtn, preferredEdge: .maxX)
    }
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
    // - MARK: - 加入视图以及布局
    func setupView(){
//        view.addSubview(addInfoBtn)
//        addInfoBtn.snp.makeConstraints{
//            $0.leading.equalToSuperview()
//            $0.top.equalToSuperview()
//            $0.height.equalTo(30)
//        }
        
        view.addSubview(refreshBtn)
        refreshBtn.snp.makeConstraints{
          //  $0.leading.equalTo(addInfoBtn.snp.trailing)
            $0.leading.equalToSuperview()

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
