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
        let item = userInfoDataArr[row]
        let textField = NSTextField(labelWithString: item[key.rawValue] as! String )
        view?.addSubview(textField)
  
        return view
    }
}
class OwnerInputExpensesViewController: NSViewController {
    var userInfoDataArr : [OwnerInputExpenses] = []
    // - MARK: - 控件
    private lazy var queryInfoBtn = NSButton(title: "查询收支信息", target: self, action: #selector(popoverQueryInfoWnd))
    private lazy var refreshBtn = NSButton(title: "刷新", target: self, action: #selector(refresh))
    private lazy var popover1 = QueryPopOver(viewController: QueryViewController())

     lazy var InputExpensesTable : NSTableView = {
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
    override func viewWillAppear() {
        InputExpenseNetwork.add()
        InputExpenseNetwork.refresh()

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
    @objc func popoverQueryInfoWnd(_ sender:NSButton){
        (popover1.contentViewController as!QueryViewController).clearValue()
        (popover1.contentViewController as! QueryViewController).queryAction = { btn in
            let queryMap = [
                "func":"inexpense",
                "user_id":LoginUserInfo.getLoginUser().userId,
                "query_name":  (self.popover1.contentViewController as! QueryViewController).queryName.stringValue,
                "query_value":  (self.popover1.contentViewController as! QueryViewController).queryValue.stringValue
            ]
            MaterialNetwork.query(para: queryMap)
        }
        (popover1.contentViewController as! QueryViewController).getCallClsPropertyName(clsName: OwnerInputExpenses.self)
        popover1.show(relativeTo: self.queryInfoBtn.bounds, of: self.queryInfoBtn, preferredEdge: .maxX)
    }
    @objc func refresh(_ sender:NSButton){
        InputExpenseNetwork.refresh()
    }

    // - MARK: - 加入视图以及布局
    func setupView(){

        view.addSubview(refreshBtn)
        refreshBtn.snp.makeConstraints{
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

