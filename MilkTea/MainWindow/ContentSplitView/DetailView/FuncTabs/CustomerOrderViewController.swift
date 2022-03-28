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
            var modifyBtn = NSButton(title: "修改", target: self, action: #selector(modifyOrder))
            modifyBtn.isBordered = false
            modifyBtn.tag = row
            var deleteBtn = NSButton(title: "删除", target: self, action: #selector(deleteOrder))
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
    var userInfoDataArr : [CustomerOrder] = []
    var editRow = -1
    var editflag = false
    var texts :[String] = []
    // - MARK: - 控件
    private lazy var addInfoBtn = NSButton(title: "添加顾客订单信息", target: self, action: #selector(popoverAddInfoWnd))
    private lazy var queryInfoBtn = NSButton(title: "查询顾客订单信息", target: self, action: #selector(popoverQueryInfoWnd))
    private lazy var refreshBtn = NSButton(title: "刷新", target: self, action: #selector(refresh))
    private lazy var popover1 = QueryPopOver(viewController: QueryViewController())
    lazy var popoverAddOrder = AddOrderPopOver(viewController: AddOrderViewController())
    lazy var userOrderTable : NSTableView = {
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
        for property in CustomerOrder.getUIName().dropFirst(){
            print(property)
            self.userOrderTable.addTableColumn(getColumn(title: property))
        }
        BaseNetWork.sendDataRequest(url: "http://localhost:8086/order/refresh", method: .post, parameters:["userid":LoginUserInfo.getLoginUser().userId] ){ code,datas,msg in
//            print(datas)
             if(code == 200){
                 (((WindowManager.shared.MainWnd.contentViewController as! MainMenuViewController)
                     .contentViewControllerItem.viewController as! ContentSplitViewController)
                   .detailViewController.tabViewItems[2].viewController as! CustomerOrderViewController).userInfoDataArr.removeAll()//清空数据源
                 for ele in datas{
                     var order = CustomerOrder(
                       customerName: (ele as!NSDictionary).object(forKey: "customerid") as! String,
                       buyingjuice: (ele as!NSDictionary).object(forKey: "buyingjuice") as! String,
                       orderingTime: (ele as!NSDictionary).object(forKey: "orderingtime") as! String,
                       juiceNumber: (ele as!NSDictionary).object(forKey: "juicenumber") as! String,
                       totalSellingPrice: (ele as!NSDictionary).object(forKey: "totalsellingprice") as! String,
                       curEvaluate: (ele as!NSDictionary).object(forKey: "curevaluate") as! String
                       )
                     (((WindowManager.shared.MainWnd.contentViewController as! MainMenuViewController)
                         .contentViewControllerItem.viewController as! ContentSplitViewController)
                       .detailViewController.tabViewItems[2].viewController as! CustomerOrderViewController).userInfoDataArr.append(order)//添加新数据
                     (((WindowManager.shared.MainWnd.contentViewController as! MainMenuViewController)
                        .contentViewControllerItem.viewController as! ContentSplitViewController)
                      .detailViewController.tabViewItems[2].viewController as! CustomerOrderViewController).userOrderTable.reloadData()//重载数据
                 }
             }
             else {
                 MsgHelper.showMsg(message:"刷新失败: \(msg)")
             }
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
    @objc func modifyOrder(_ sender:NSButton){
        editRow = sender.tag//获取选中行
        var textFields = [
            (self.userOrderTable.view(atColumn: 0, row: editRow, makeIfNecessary: true)?.subviews[0] as! NSTextField),
            (self.userOrderTable.view(atColumn: 1, row: editRow, makeIfNecessary: true)?.subviews[0] as! NSTextField),
            (self.userOrderTable.view(atColumn: 2, row: editRow, makeIfNecessary: true)?.subviews[0] as! NSTextField),
            (self.userOrderTable.view(atColumn: 3, row: editRow, makeIfNecessary: true)?.subviews[0] as! NSTextField),
            (self.userOrderTable.view(atColumn: 4, row: editRow, makeIfNecessary: true)?.subviews[0] as! NSTextField),
            (self.userOrderTable.view(atColumn: 5, row: editRow, makeIfNecessary: true)?.subviews[0] as! NSTextField)
        ]
        if sender.title == "提交" {
            print(sender.tag+1)
            for (index,textField) in textFields.enumerated() {
                if (index == 1 || index == 3 || index == 4){
                    continue
                }
                textField.textColor = NSColor.black
                textField.isEditable = false

            }
            sender.title = "修改"
            editRow = -1
            self.editflag = false
            self.texts.removeAll()
            textFields.removeAll()
            return
        }

        if (editflag == true && editRow != -1){ //选中某行
            MsgHelper.showMsg(message: "您已选中某行,请重新选择")
            for (index,textField) in textFields.enumerated() {
                if (index == 1 || index == 3 || index == 4) {
                    continue
                }
                textField.textColor = NSColor.black
                textField.isEditable = false
                textField.stringValue = self.texts[index]
            }
            sender.title = "修改"
            editRow = -1
            self.editflag = false
            self.texts.removeAll()
            textFields.removeAll()
            return
        }
        if sender.title == "修改"{
            self.texts = [
                textFields[0].stringValue,
//                textFields[1].stringValue,
                textFields[2].stringValue,
//                textFields[3].stringValue,
//                textFields[4].stringValue,
                textFields[5].stringValue
            ]
            for (index,textField) in textFields.enumerated() {
                if (index == 1 || index == 3 || index == 4 ){
                    continue
                }
                textField.textColor = NSColor.red
                textField.isEditable = true
            }
            sender.title = "提交"
            self.editflag = true
        }

 
        
        
        
//        let queryMap = [
//            "func":"order",
//            "userid":LoginUserInfo.getLoginUser().userId,
//            "query_name":  queryName.stringValue,
//            "query_value":  queryValue.stringValue
//        ]
//        BaseNetWork.sendDataRequest(url: "http://localhost:8086/order/modify", method: .post, parameters:["userid":LoginUserInfo.getLoginUser().userId] ){ code,datas,msg in
////            print(datas)
//             if(code == 200){
//                 MsgHelper.showMsg(message:"刷新成功")
//                 (((WindowManager.shared.MainWnd.contentViewController as! MainMenuViewController)
//                     .contentViewControllerItem.viewController as! ContentSplitViewController)
//                   .detailViewController.tabViewItems[2].viewController as! CustomerOrderViewController).userInfoDataArr.removeAll()//清空数据源
//                 for ele in datas{
//                     var order = CustomerOrder(
//                       customerName: (ele as!NSDictionary).object(forKey: "customerid") as! String,
//                       buyingjuice: (ele as!NSDictionary).object(forKey: "buyingjuice") as! String,
//                       orderingTime: (ele as!NSDictionary).object(forKey: "orderingtime") as! String,
//                       juiceNumber: (ele as!NSDictionary).object(forKey: "juicenumber") as! String,
//                       totalSellingPrice: (ele as!NSDictionary).object(forKey: "totalsellingprice") as! String,
//                       curEvaluate: (ele as!NSDictionary).object(forKey: "curevaluate") as! String
//                       )
//                     (((WindowManager.shared.MainWnd.contentViewController as! MainMenuViewController)
//                         .contentViewControllerItem.viewController as! ContentSplitViewController)
//                       .detailViewController.tabViewItems[2].viewController as! CustomerOrderViewController).userInfoDataArr.append(order)//添加新数据
//                     (((WindowManager.shared.MainWnd.contentViewController as! MainMenuViewController)
//                        .contentViewControllerItem.viewController as! ContentSplitViewController)
//                      .detailViewController.tabViewItems[2].viewController as! CustomerOrderViewController).userOrderTable.reloadData()//重载数据
//                 }
//             }
//             else {
//                 MsgHelper.showMsg(message:"刷新失败: \(msg)")
//             }
//        }

    }
    @objc func deleteOrder(_ sender:NSButton){

    }
    @objc func popoverAddInfoWnd(_ sender:NSButton){
        (popoverAddOrder.contentViewController as!AddOrderViewController).clearValue()
        popoverAddOrder.show(relativeTo: self.addInfoBtn.bounds, of: self.addInfoBtn, preferredEdge: .maxX)
    }
    @objc func popoverQueryInfoWnd(_ sender:NSButton){
        (popover1.contentViewController as!QueryViewController).clearValue()
        (popover1.contentViewController as! QueryViewController).getCallClsPropertyName(clsName: CustomerOrder.self)
        popover1.show(relativeTo: self.queryInfoBtn.bounds, of: self.queryInfoBtn, preferredEdge: .maxX)
        
    }
    @objc func refresh(){
        BaseNetWork.sendDataRequest(url: "http://localhost:8086/order/refresh", method: .post, parameters:["userid":LoginUserInfo.getLoginUser().userId] ){ code,datas,msg in
//            print(datas)
             if(code == 200){
                 MsgHelper.showMsg(message:"刷新成功")
                 (((WindowManager.shared.MainWnd.contentViewController as! MainMenuViewController)
                     .contentViewControllerItem.viewController as! ContentSplitViewController)
                   .detailViewController.tabViewItems[2].viewController as! CustomerOrderViewController).userInfoDataArr.removeAll()//清空数据源
                 for ele in datas{
                     var order = CustomerOrder(
                       customerName: (ele as!NSDictionary).object(forKey: "customerid") as! String,
                       buyingjuice: (ele as!NSDictionary).object(forKey: "buyingjuice") as! String,
                       orderingTime: (ele as!NSDictionary).object(forKey: "orderingtime") as! String,
                       juiceNumber: (ele as!NSDictionary).object(forKey: "juicenumber") as! String,
                       totalSellingPrice: (ele as!NSDictionary).object(forKey: "totalsellingprice") as! String,
                       curEvaluate: (ele as!NSDictionary).object(forKey: "curevaluate") as! String
                       )
                     (((WindowManager.shared.MainWnd.contentViewController as! MainMenuViewController)
                         .contentViewControllerItem.viewController as! ContentSplitViewController)
                       .detailViewController.tabViewItems[2].viewController as! CustomerOrderViewController).userInfoDataArr.append(order)//添加新数据
                     (((WindowManager.shared.MainWnd.contentViewController as! MainMenuViewController)
                        .contentViewControllerItem.viewController as! ContentSplitViewController)
                      .detailViewController.tabViewItems[2].viewController as! CustomerOrderViewController).userOrderTable.reloadData()//重载数据
                 }
             }
             else {
                 MsgHelper.showMsg(message:"刷新失败: \(msg)")
             }
        }
       
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
