//
//  JuiceMaterialViewController.swift
//  MilkTea
//
//  Created by tiger on 2022/2/24.
//

import Cocoa
extension JuiceMaterialViewController :NSTableViewDataSource{
    func numberOfRows(in tableView: NSTableView) -> Int {
        return datas.count
    }

}
extension JuiceMaterialViewController :NSTableViewDelegate{
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
            let item = datas[row]
            let textField = NSTextField(labelWithString: item[key.rawValue] as! String )
            view?.addSubview(textField)
        }else{
            let modifyBtn = NSButton(title: "修改", target: self, action: #selector(modify))
            modifyBtn.isBordered = false
            modifyBtn.tag = row
            let deleteBtn = NSButton(title: "删除", target: self, action: #selector(delete))
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
class JuiceMaterialViewController: NSViewController {
    // - MARK: - 数据
    var datas : [JuiceMaterial] = []
    var editRow = -1
    var editflag = false
    var texts :[String] = []
    // - MARK: - 控件
    private lazy var addInfoBtn = NSButton(title: "添加原料购入信息", target: self, action: #selector(popoverAddInfoWnd))
    private lazy var queryInfoBtn = NSButton(title: "查询原料购入信息", target: self, action: #selector(query))
    private lazy var refreshBtn = NSButton(title: "刷新", target: self, action: #selector(refresh))
    private lazy var popover1 = QueryPopOver(viewController: QueryViewController())
    lazy var popoverAddMaterial = AddMaterialPopOver(viewController: AddMaterialViewController())
    lazy var juiceMaterialTable : NSTableView = {
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
        ctrl.documentView = juiceMaterialTable
        return ctrl
    }()
    // - MARK: - 生命周期
    override func loadView() {
        view = NSView()
        for property in JuiceMaterial.getUIName().dropFirst().dropFirst(){
            self.juiceMaterialTable.addTableColumn(getColumn(title: property))
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    override func viewWillAppear() {
        MaterialNetwork.refresh()
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
    @objc func refresh(_ sender:NSButton){
        MaterialNetwork.refresh()
    }
    @objc func modify(_ sender:NSButton){
        if editRow == -1 {
            editRow = sender.tag
        }
        else if editRow != sender.tag{
            editflag = true //已编辑过
        }
         //获取选中行
        var textFields = [
            (self.juiceMaterialTable.view(atColumn: 0, row: editRow, makeIfNecessary: true)?.subviews[0] as! NSTextField),
            (self.juiceMaterialTable.view(atColumn: 1, row: editRow, makeIfNecessary: true)?.subviews[0] as! NSTextField),
            (self.juiceMaterialTable.view(atColumn: 2, row: editRow, makeIfNecessary: true)?.subviews[0] as! NSTextField),
            (self.juiceMaterialTable.view(atColumn: 3, row: editRow, makeIfNecessary: true)?.subviews[0] as! NSTextField),
            (self.juiceMaterialTable.view(atColumn: 4, row: editRow, makeIfNecessary: true)?.subviews[0] as! NSTextField)
        ]
        if sender.title == "提交" {

            MaterialNetwork.modify(para: [
                "material_id":datas[sender.tag].id,
                "user_id":LoginUserInfo.getLoginUser().userId,
                "material_name":textFields[0].stringValue,
                "material_number":textFields[2].stringValue,
                "per_price":textFields[1].stringValue,
                "material_month_buying_time":textFields[3].stringValue,
                "material_month_total_price":textFields[4].stringValue,
            ])
            
            //界面变回原样
            for (index,textField) in textFields.enumerated() {
                if (index == 1 || index == 2 || index == 4) {
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
        if(editflag == true){
            MsgHelper.showMsg(message: "您已选中某行,请重新选择")
            for (index,textField) in textFields.enumerated() {
                if (index == 1 || index == 2 || index == 4) {
                    continue
                }
                textField.textColor = NSColor.black
                textField.isEditable = false
                textField.stringValue = self.texts[index]
            }
            (self.juiceMaterialTable.view(atColumn: 5, row: editRow, makeIfNecessary: true)?.subviews[0] as! NSButton).title = "修改"

            editRow = -1
            self.editflag = false
            self.texts.removeAll()
            textFields.removeAll()
            return
        }
    
        if sender.title == "修改"{
            self.texts = [
                textFields[0].stringValue,
                textFields[1].stringValue,
                textFields[2].stringValue,
                textFields[3].stringValue,
                textFields[4].stringValue,
            ]
            for (index,textField) in textFields.enumerated() {
                if (index == 1 || index == 2 || index == 4) {
                    continue
                }
                textField.textColor = NSColor.red
                textField.isEditable = true
            }
            sender.title = "提交"
            self.editflag = true
        }

    }
    @objc func delete(_ sender:NSButton){
        MsgHelper.judgeMsg(message: "确认删除?", window: self.view.window!) { response in
            if (response == .alertFirstButtonReturn){
                MaterialNetwork.delete(para: [
                    "user_id":LoginUserInfo.getLoginUser().userId,
                    "material_id":self.datas[sender.tag].id,
                    "material_name":self.datas[sender.tag].juiceMaterialName,
                    "material_number":self.datas[sender.tag].materialNumber,
                    "per_price":self.datas[sender.tag].materialPerPrice,
                    "material_month_buying_time":self.datas[sender.tag].materialMonthBuyingTime,
                    "material_month_total_price":self.datas[sender.tag].materialMonthTotalPrice
                ])
              
            }else if(response == .alertSecondButtonReturn){
                print("cancel")

            }
        }
    }
    @objc func query(_ sender:NSButton){
        (popover1.contentViewController as!QueryViewController).clearValue()
        (popover1.contentViewController as! QueryViewController).queryAction = { btn in
            let queryMap = [
                "func":"material",
                "user_id":LoginUserInfo.getLoginUser().userId,
                "query_name":  (self.popover1.contentViewController as! QueryViewController).queryName.stringValue,
                "query_value":  (self.popover1.contentViewController as! QueryViewController).queryValue.stringValue
            ]
            MaterialNetwork.query(para: queryMap)
        }
        (popover1.contentViewController as! QueryViewController).getCallClsPropertyName(clsName: JuiceMaterial.self)
        popover1.show(relativeTo: self.queryInfoBtn.bounds, of: self.queryInfoBtn, preferredEdge: .maxX)
    }
    @objc func popoverAddInfoWnd(_ sender:NSButton){
        (popoverAddMaterial.contentViewController as!AddMaterialViewController).clearValue()
        popoverAddMaterial.show(relativeTo: self.addInfoBtn.bounds, of: self.addInfoBtn, preferredEdge: .maxX)
        
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
