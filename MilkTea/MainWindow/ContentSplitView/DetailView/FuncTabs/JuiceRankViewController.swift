//
//  JuiceOrderViewController.swift
//  MilkTea
//
//  Created by tiger on 2022/2/24.
//

import Cocoa
extension JuiceRankViewController :NSTableViewDataSource{
    func numberOfRows(in tableView: NSTableView) -> Int {
        return juiceRankArr.count
    }

}
extension JuiceRankViewController :NSTableViewDelegate{
//    func tableView(_ tableView: NSTableView, sortDescriptorsDidChange oldDescriptors: [NSSortDescriptor]) {
//      var arr =  NSMutableArray(array: juiceRankArr)
//        arr.sort(using: tableView.sortDescriptors)
//        juiceRankArr = arr as! [JuiceRank]
//        tableView.reloadData()
//    }
    func tableView(_ tableView: NSTableView, didClick tableColumn: NSTableColumn) {
        switch tableColumn.headerCell.stringValue{
            case "饮品历史销售数量":
            self.juiceRankArr.sort(by: { juice1,juice2 in
                juice1.juiceSoldNumber>juice2.juiceSoldNumber
            })
                break
            case "总销售额":
            self.juiceRankArr.sort(by: { juice1,juice2 in
                juice1.sellingTotalPrice>juice2.sellingTotalPrice
            })
                break
            case "好评数":
            self.juiceRankArr.sort(by: { juice1,juice2 in
                juice1.goodEvaluateNum>juice2.goodEvaluateNum
            })
                break
            default:
                break
        }
        tableView.reloadData()
       
    }
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        //获取当前列的标识符
        let key = (tableColumn?.identifier)!
        //创建单元格cell视图
        var view = tableView.makeView(withIdentifier: key, owner: self)
        if (view == nil){
            view = NSView()
        }
        //判断当前列的标识符是哪一列
        let item = juiceRankArr[row]
        let textField = NSTextField(labelWithString: item[key.rawValue] as! String )
        view?.addSubview(textField)
        return view
    }
}
class JuiceRankViewController: NSViewController {
   
    var juiceRankArr : [JuiceRank] = []
    // - MARK: - 控件
     lazy var juiceRankTable : NSTableView = {
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
        ctrl.documentView = juiceRankTable
        return ctrl
    }()
    // - MARK: - 生命周期
    override func loadView() {
        view = NSView()
        for property in JuiceRank.getUIName().dropFirst(){
            self.juiceRankTable.addTableColumn(getColumn(title: property))

        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    override func viewWillAppear() {
        JuiceTypeNetwork.refresh()
        juiceRankArr.removeAll()
     
   
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
 
    // - MARK: - 加入视图以及布局
    func setupView(){
        view.addSubview(scroll)
        scroll.snp.makeConstraints{
            $0.trailing.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
        }

        
        
    }
    
}
