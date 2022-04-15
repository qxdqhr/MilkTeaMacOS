//
//  FunctionBarViewItem.swift
//  MilkTea
//
//  Created by tiger on 2022/2/21.
//

import Cocoa

//OutLine子类
class FuncBarOutLineView:NSOutlineView{
    var detailPages:DetailViewController = DetailViewController()
    override func mouseDown(with event: NSEvent) {
        let pt = convert(event.locationInWindow, from: nil)
        let row = self.row(at: pt)
        print("row:\(row),pt:\(pt)")

        let funcModel = self.item(atRow: row) as? FunctionModel
        #if OWNER
        switch funcModel?.name{
        case "顾客信息管理":
            detailPages.tabView.selectTabViewItem(at: 1)
        case "顾客订单管理":
            detailPages.tabView.selectTabViewItem(at: 2)
        case "饮品种类管理":
            detailPages.tabView.selectTabViewItem(at: 3)
        case "饮品原料管理":
            detailPages.tabView.selectTabViewItem(at: 4)
        case "饮品榜单管理":
            detailPages.tabView.selectTabViewItem(at: 5)
        case "月度收支管理":
            detailPages.tabView.selectTabViewItem(at: 6)
        case "报表管理":
            detailPages.tabView.selectTabViewItem(at: 7)
        case "图表管理":
            detailPages.tabView.selectTabViewItem(at: 8)
        case "告警信息管理":
            detailPages.tabView.selectTabViewItem(at: 9)
        default://欢迎界面
            detailPages.tabView.selectTabViewItem(at: 0)
        }
        #else
        switch funcModel?.name{
        case "饮品种类管理":
            detailPages.tabView.selectTabViewItem(at: 3)
        case "饮品原料管理":
            detailPages.tabView.selectTabViewItem(at: 4)
        case "饮品榜单管理":
            detailPages.tabView.selectTabViewItem(at: 5)
        case "月度收支管理":
            detailPages.tabView.selectTabViewItem(at: 6)
        case "报表管理":
            detailPages.tabView.selectTabViewItem(at: 7)
        case "图表管理":
            detailPages.tabView.selectTabViewItem(at: 8)
        case "告警信息管理":
            detailPages.tabView.selectTabViewItem(at: 9)
        case "商户管理":
            detailPages.tabView.selectTabViewItem(at: 10)
        default://欢迎界面
            detailPages.tabView.selectTabViewItem(at: 0)
        }
        #endif
    }
}
//数据节点
class FunctionModel:NSObject{
    var name : String?
    lazy var childNodes:Array = {
        return [FunctionModel]()
    }()
}
class FunctionBarViewController: NSViewController {
    // - MARK: - 数据
    var functionModel = FunctionModel()
    func configData() {
        #if OWNER
        
        //顾客管理模块
        let customerManagmentModule =  FunctionModel()
        customerManagmentModule.name = "顾客管理"
        self.functionModel.childNodes.append(customerManagmentModule)
        
        //子节点
        let customerInfoNode = FunctionModel()
        customerInfoNode.name = "顾客信息管理"
        let customerOrderNode = FunctionModel()
        customerOrderNode.name = "顾客订单管理"
        customerManagmentModule.childNodes.append(customerInfoNode)
        customerManagmentModule.childNodes.append(customerOrderNode)
        #endif
        
        //饮品管理模块
        let juiceManagmentModule =  FunctionModel()
        juiceManagmentModule.name = "饮品管理"
        self.functionModel.childNodes.append(juiceManagmentModule)
        
        //子节点
        let juiceTypeNode = FunctionModel()
        juiceTypeNode.name = "饮品种类管理"
#if OWNER
        let materialNode = FunctionModel()
        materialNode.name = "饮品原料管理"
#endif
        let juiceRankNode = FunctionModel()
        juiceRankNode.name = "饮品榜单管理"
        juiceManagmentModule.childNodes.append(juiceTypeNode)
#if OWNER
        juiceManagmentModule.childNodes.append(materialNode)
#endif
        juiceManagmentModule.childNodes.append(juiceRankNode)

        //营销管理模块
        let marketingModule =  FunctionModel()
        marketingModule.name = " 营销管理"
        self.functionModel.childNodes.append(marketingModule)
        
        // - MARK: 角色区分显示不同的控件
        //子节点:加盟商
        let inputExpensesNode = FunctionModel()
        inputExpensesNode.name = "月度收支管理"
        let excelNode = FunctionModel()
        excelNode.name = "报表管理"
        marketingModule.childNodes.append(inputExpensesNode)
        marketingModule.childNodes.append(excelNode)
        //子节点:经销商
        let graphicNode = FunctionModel()
        graphicNode.name = "图表管理"
        let alertNode = FunctionModel()
        alertNode.name = "告警信息管理"

        marketingModule.childNodes.append(graphicNode)
        marketingModule.childNodes.append(alertNode)
        
        #if EXOWNER
        let alertOwnerNode = FunctionModel()
        alertOwnerNode.name = "商户管理"
        marketingModule.childNodes.append(alertOwnerNode)
        #endif
        
        self.outLineView.reloadData()
    }
    // - MARK: - 控件
    var outLineView :FuncBarOutLineView = {
        var outline = FuncBarOutLineView()
        outline.allowsColumnResizing = true
        outline.headerView = nil
        outline.addTableColumn(NSTableColumn(identifier: .init(rawValue: "func")))
        outline.columnAutoresizingStyle = .firstColumnOnlyAutoresizingStyle
        outline.usesAlternatingRowBackgroundColors = false;//背景颜色的交替，一行白色，一行灰色。

        return outline
    }()
    private lazy var scroll:NSScrollView = {
       var scroll = NSScrollView()
        scroll.documentView = self.outLineView
        scroll.hasVerticalScroller = true
        scroll.autohidesScrollers = true
        
        return scroll
    }()
    // - MARK: - 生命周期
    override func loadView() {
        view = NSView()
        configData()
        outLineView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        outLineView.dataSource = self
        outLineView.delegate = self
        setupView()
        
    }
    // - MARK: - 重写代理函数


    // - MARK: - 重写其他函数
    
    // - MARK: - 事件函数
    
    // - MARK: - 加入视图以及布局
    func setupView(){
        view.addSubview(scroll)
        scroll.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
            $0.size.greaterThanOrEqualToSuperview()
        }
    }
}
extension FunctionBarViewController : NSOutlineViewDataSource{
    //数据源协议方法:每个节点的子节点数
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        let rootNode:FunctionModel
        if item != nil{
            rootNode = item as! FunctionModel
        }
        else{
            rootNode = self.functionModel
        }
        return rootNode.childNodes.count
    }
    //数据源协议方法:节点的数据
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        let rootNode:FunctionModel
        if item != nil{
            rootNode = item as! FunctionModel
        }
        else{
            rootNode = self.functionModel
        }
        return rootNode.childNodes[index]
    }
    //数据源协议方法:节点是否可以展开
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        let rootNode = item as! FunctionModel
        return rootNode.childNodes.count > 0
    }
}
extension FunctionBarViewController:NSOutlineViewDelegate{
    //代理方法实现:根据节点数据返回节点视图
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        let model = item as! FunctionModel
        var view = outlineView.makeView(withIdentifier: (tableColumn?.identifier)! , owner: nil)
        if view == nil{
            view = NSView()
            let title = NSTextField(labelWithString: model.name!)
            view?.addSubview(title)
            title.snp.makeConstraints{
                $0.edges.equalToSuperview()
                $0.size.equalToSuperview()
            }
        }
        return view
    }
    
    //代理方法实现:
    func outlineView(_ outlineView: NSOutlineView, heightOfRowByItem item: Any) -> CGFloat {
        return 30
    }
 
}
