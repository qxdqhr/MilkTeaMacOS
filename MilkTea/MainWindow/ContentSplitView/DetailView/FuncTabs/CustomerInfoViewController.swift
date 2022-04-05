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
//        if(key.rawValue != "操作"){
            let item = userInfoDataArr[row]
            let textField = NSTextField(labelWithString: item[key.rawValue] )
            view?.addSubview(textField)
//        }else{
//            var modifyBtn = NSButton(title: "修改", target: self, action: #selector(modifyCustomer(_:)))
//            modifyBtn.isBordered = false
//            modifyBtn.tag = row
//            var deleteBtn = NSButton(title: "删除", target: self, action: #selector(deleteCustomer(_:)))
//            deleteBtn.isBordered = false
//            deleteBtn.tag = row
//
//
//            view?.addSubview(modifyBtn)
//            view?.addSubview(deleteBtn)
//            modifyBtn.snp.makeConstraints{
//                $0.leading.equalToSuperview()
//            }
//            deleteBtn.snp.makeConstraints{
//                $0.leading.equalTo(modifyBtn.snp.trailing)
//            }
//        }
        return view
    }
}
class CustomerInfoViewController: NSViewController {
    // - MARK: - 数据
    var userInfoDataArr : [CustomerInfo] = []
    var editRow = -1
    var editflag = false
    var texts :[String] = []
    // - MARK: - 控件
    private lazy var queryInfoBtn = NSButton(title: "查询顾客信息", target: self, action: #selector(popoverAddInfoWnd))
    private lazy var refreshBtn = NSButton(title: "刷新", target: self, action: #selector(refresh))
    private lazy var popover1 = QueryPopOver(viewController: QueryViewController())
    lazy var userInfoTable : NSTableView = {
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
        for property in CustomerInfo.getUIName().dropFirst(){
            self.userInfoTable.addTableColumn(getColumn(title: property))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    override func viewWillAppear() {
        CustomerNetwork.refresh()
        
    }
    // - MARK: - 事件函数
    @objc func popoverAddInfoWnd(_ sender:NSButton){
        (popover1.contentViewController as! QueryViewController).getCallClsPropertyName(clsName: CustomerInfo.self)
        (popover1.contentViewController as! QueryViewController).queryAction = { btn in
            let queryMap = [
                "func":"customer",
                "userid":LoginUserInfo.getLoginUser().userId,
                "query_name":  (self.popover1.contentViewController as! QueryViewController).queryName.stringValue,
                "query_value":  (self.popover1.contentViewController as! QueryViewController).queryValue.stringValue
            ]
            CustomerNetwork.query(para: queryMap)
        }
        popover1.show(relativeTo: self.queryInfoBtn.bounds, of: self.queryInfoBtn, preferredEdge: .maxX)
    }
    @objc func refresh(_ sender:NSButton){
        CustomerNetwork.refresh()
    }
//    @objc func modifyCustomer(_ sender:NSButton){
//        if editRow == -1 {
//            editRow = sender.tag
//        }
//        else if editRow != sender.tag{
//            editflag = true //已编辑过
//        }
//         //获取选中行
//        var textFields = [
//            (self.userInfoTable.view(atColumn: 0, row: editRow, makeIfNecessary: true)?.subviews[0] as! NSTextField),
//            (self.userInfoTable.view(atColumn: 1, row: editRow, makeIfNecessary: true)?.subviews[0] as! NSTextField),
//            (self.userInfoTable.view(atColumn: 2, row: editRow, makeIfNecessary: true)?.subviews[0] as! NSTextField)
//        ]
//        if sender.title == "提交" {
//
//            CustomerNetwork.modify(para: [
//            "customerid":self.userInfoDataArr[sender.tag].Id,
//            "userid":LoginUserInfo.getLoginUser().userId,
//            "name":self.userInfoDataArr[sender.tag].customerName,
//            "buying_time":self.userInfoDataArr[sender.tag].buyingTime,
//            "recent_evaluate":self.userInfoDataArr[sender.tag].recentEvaluate,
//        ])
//
//            //界面变回原样
//            for (index,textField) in textFields.enumerated() {
//                if (index == 0){
//                    continue
//                }
//                textField.textColor = NSColor.black
//                textField.isEditable = false
//
//            }
//            sender.title = "修改"
//            editRow = -1
//            self.editflag = false
//            self.texts.removeAll()
//            textFields.removeAll()
//            return
//        }
//        if(editflag == true){
//            MsgHelper.showMsg(message: "您已选中某行,请重新选择")
//            for (index,textField) in textFields.enumerated() {
//                if (index == 0) {
//                    continue
//                }
//                textField.textColor = NSColor.black
//                textField.isEditable = false
//                textField.stringValue = self.texts[index]
//            }
//            (self.userInfoTable.view(atColumn: 3, row: editRow, makeIfNecessary: true)?.subviews[0] as! NSButton).title = "修改"
//
//            editRow = -1
//            self.editflag = false
//            self.texts.removeAll()
//            textFields.removeAll()
//            return
//        }
//
//        if sender.title == "修改"{
//            self.texts = [
//                textFields[0].stringValue,
//                textFields[1].stringValue,
//                textFields[2].stringValue,
//            ]
//            for (index,textField) in textFields.enumerated() {
//                if (index == 0){
//                    continue
//                }
//                textField.textColor = NSColor.red
//                textField.isEditable = true
//            }
//            sender.title = "提交"
//            self.editflag = true
//        }
//
//    }
//    @objc func deleteCustomer(_ sender:NSButton){
//        MsgHelper.judgeMsg(message: "确认删除?", window: self.view.window!) { response in
//            if (response == .alertFirstButtonReturn){
//                OrderNetwork.delete(para: [
//                    "customerid":self.userInfoDataArr[sender.tag].Id,
//                    "userid":LoginUserInfo.getLoginUser().userId,
//                    "name":self.userInfoDataArr[sender.tag].customerName,
//                    "buying_time":self.userInfoDataArr[sender.tag].buyingTime,
//                    "recent_evaluate":self.userInfoDataArr[sender.tag].recentEvaluate,
//                ])
//
//            }else if(response == .alertSecondButtonReturn){
//                print("cancel")
//
//            }
//        }
//    }
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
