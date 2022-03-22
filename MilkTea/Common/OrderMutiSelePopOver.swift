
import Cocoa
class OrderMutiSelePopOver:NSPopover{
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
class OrderMutiSeleViewController:NSViewController{
    
}

extension JuiceSeleTableViewController :NSTableViewDataSource{
    func numberOfRows(in tableView: NSTableView) -> Int {
        return juiceTypeArr.count
    }

}
extension JuiceSeleTableViewController :NSTableViewDelegate{
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        //获取当前列的标识符
        let key = (tableColumn?.identifier)!
        //创建单元格cell视图
        var view = tableView.makeView(withIdentifier: key, owner: self)
        if (view == nil){
            view = NSView()
            
        }
        //判断当前列的标识符是哪一列
        let item = juiceTypeArr[row]

        var juiceTypeComboBox :NSButton = {
            var juiceTypeComboBox = NSButton(title: (item as!JuiceType).juiceName, target: self, action: #selector(addSelection))
            return juiceTypeComboBox
        }()
        view?.addSubview(juiceTypeComboBox)
        juiceTypeComboBox.snp.makeConstraints{
            $0.center.equalToSuperview()
            $0.size.equalToSuperview()
        }
        return view
    }
    @objc func addSelection(_ sender:NSButton){
        let ele = "\(sender.title)"
        if selectJuiceNames.contains(ele){
            selectJuiceNames.remove(ele)
        }else{
            selectJuiceNames.insert(ele)
        }
    }

}
class JuiceSeleTableViewController: NSViewController {
    lazy var comfirmBtn: NSButton = {
        var comfirmBtn = NSButton(title: "确认选择", target: self, action: #selector(updateSelection))
        return comfirmBtn
    }()
    lazy var juiceTypeArr:[JuiceType] =
    (((WindowManager.shared.MainWnd.contentViewController as! MainMenuViewController)
        .contentViewControllerItem.viewController as! ContentSplitViewController)
        .detailViewController.tabViewItems[3].viewController as! JuiceTypeSplitViewController)
        .juiceTypeSummaryViewController.data
    
    var selectJuiceNames = Set<String>()
    lazy var selectJuices :Set<JuiceType> = {
        var selectJuices = Set<JuiceType>()
        for juice in juiceTypeArr{
            selectJuices.insert(juice)
        }
        return selectJuices
    }()
    private lazy var juiceMaterialTable : NSTableView = {
        var userInfoTable = NSTableView()
        userInfoTable.delegate = self
        userInfoTable.dataSource = self
        userInfoTable.usesAlternatingRowBackgroundColors = true
        userInfoTable.columnAutoresizingStyle = .uniformColumnAutoresizingStyle
        userInfoTable.allowsColumnResizing = false
        userInfoTable.allowsColumnReordering = false
        userInfoTable.headerView?.frame = .zero
        return userInfoTable
    }()
    
    private lazy var scroll: NSScrollView = {
        var ctrl  = NSScrollView()
        ctrl.documentView = juiceMaterialTable
        return ctrl
    }()
    // - MARK: - 生命周期
    override func loadView() {
        view = NSView(frame: NSRect(x: 200, y: 200, width: 400, height: 400))
        self.juiceMaterialTable.addTableColumn(getColumn(title: ""))

        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    #if OWNER
    var delegate =
    (((WindowManager.shared.MainWnd.contentViewController as! MainMenuViewController)
        .contentViewControllerItem.viewController as! ContentSplitViewController)
        .detailViewController.tabViewItems[2].viewController as! CustomerOrderViewController)
        .popoverAddOrder.contentViewController as! AddOrderViewController
    #endif
    @objc func updateSelection(_ sender:NSButton){
        var selectJuice = ""
        var totalJuicePrice :Double = 0.0
        var juiceNum = 0
        for ele in self.selectJuiceNames{
            selectJuice.append("\(ele) ")
            juiceNum+=1
            for juice in self.juiceTypeArr{
                if(juice.juiceName == ele){
                    totalJuicePrice += Double(juice.price)!
                }
            }
        }
        delegate.sendJuicesStringToBtn(juiceString:selectJuice,juiceNum:juiceNum,juicePrice:totalJuicePrice)

    }
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

    // - MARK: - 加入视图以及布局
    func setupView(){
   
        view.addSubview(scroll)
        scroll.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.equalTo(300)
            $0.trailing.equalToSuperview()
        }
        view.addSubview(comfirmBtn)
        comfirmBtn.snp.makeConstraints{
            $0.top.equalTo(scroll.snp.bottom)
            $0.leading.equalToSuperview()
            $0.height.equalTo(100)
        }
    }
}

