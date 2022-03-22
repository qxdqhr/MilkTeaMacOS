//
//  inputExpensesViewController.swift
//  MilkTea
//
//  Created by tiger on 2022/2/24.
//

import Cocoa


extension OwnerInputExpensesViewController :NSTableViewDataSource{
    func numberOfRows(in tableView: NSTableView) -> Int {
        return userInfoDataArr.count
    }

}
extension OwnerInputExpensesViewController :NSTableViewDelegate{
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
            var detailBtn = NSButton(title: "查看详情", target: self, action: #selector(popoverAddInfoWnd))
            detailBtn.isBordered = false
            detailBtn.tag = row

            view?.addSubview(modifyBtn)
            view?.addSubview(deleteBtn)
            view?.addSubview(detailBtn)
            modifyBtn.snp.makeConstraints{
                $0.leading.equalToSuperview()
            }
            deleteBtn.snp.makeConstraints{
                $0.leading.equalTo(modifyBtn.snp.trailing)
            }
            detailBtn.snp.makeConstraints{
                $0.leading.equalTo(deleteBtn.snp.trailing)
            }
        }
        return view
    }
}
class OwnerInputExpensesViewController: NSViewController {
    var userInfoDataArr : [OwnerInputExpenses] = [
        OwnerInputExpenses(month: "1", totalIncome: "1", totalExpence: "1", milkTeaIncome: "2", milkTeaExpence: "1", fruitTeaIncome: "1", fruitTeaExpence: "12", vegetableTeaIncome: "2", vegetableTeaExpence: "2", otherExpence: "3")
    ]
    // - MARK: - 控件
    private var addInfoBtn = NSButton(title: "添加收支信息", target: self, action: #selector(popoverAddInfoWnd))
    private lazy var queryInfoBtn = NSButton(title: "查询收支信息", target: self, action: #selector(popoverAddInfoWnd))
    private lazy var refreshBtn = NSButton(title: "刷新", target: self, action: #selector(popoverAddInfoWnd))
    private lazy var popover1 = QueryPopOver(viewController: QueryViewController())

    private lazy var InputExpensesTable : NSTableView = {
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
        ctrl.documentView = InputExpensesTable
        return ctrl
    }()
    // - MARK: - 生命周期
    override func loadView() {
        view = NSView()
        for property in OwnerInputExpenses.getUIName(){
            self.InputExpensesTable.addTableColumn(getColumn(title: property))

        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    // - MARK: - 重写代理函数
    
    // - MARK: - 重写其他函数
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
        (popover1.contentViewController as! QueryViewController).getCallClsPropertyName(clsName: OwnerInputExpenses.self)
        popover1.show(relativeTo: self.queryInfoBtn.bounds, of: self.queryInfoBtn, preferredEdge: .maxX)
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

