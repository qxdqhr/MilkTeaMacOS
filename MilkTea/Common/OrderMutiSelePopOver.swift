
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
        //子视图控件
        var juiceTypeComboBox = NSButton(title: item.juiceName, target: self, action: #selector(getNum))
        var addJuiceBtn = NSButton(title: "增加饮品", target: self, action: #selector(addSelection))
        var removeJuiceBtn = NSButton(title: "减少饮品", target: self, action: #selector(removeSelection))
        juiceTypeComboBox.stringValue = item.juiceName
        juiceTypeComboBox.tag = row
        addJuiceBtn.tag = row
        removeJuiceBtn.tag = row

        view?.addSubview(juiceTypeComboBox)
        view?.addSubview(addJuiceBtn)
        view?.addSubview(removeJuiceBtn)
        juiceTypeComboBox.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
        }
        addJuiceBtn.snp.makeConstraints{
            $0.leading.equalTo(juiceTypeComboBox.snp.trailing)
            $0.top.equalToSuperview()
        }
        removeJuiceBtn.snp.makeConstraints{
            $0.leading.equalTo(addJuiceBtn.snp.trailing)
            $0.top.equalToSuperview()
        }
        return view
    }
    @objc func getNum(_ sender:NSButton){
        let ele = juiceTypeArr[sender.tag].juiceName
        if self.selectJuiceNames[ele] != nil{
            sender.title = "\(ele): \(self.selectJuiceNames[ele]!)"
        }
     
    }
    @objc func addSelection(_ sender:NSButton){
        let ele = juiceTypeArr[sender.tag].juiceName
        
        if(self.selectJuiceNames[ele] == nil||self.selectJuiceNames[ele] == 0){
            self.selectJuiceNames[ele] = 1
        }
        else{
            self.selectJuiceNames[ele]! += 1
        }
        getNum(self.juiceMaterialTable.view(atColumn: 0, row: sender.tag, makeIfNecessary: true)?.subviews[0] as!NSButton)
    }
    @objc func removeSelection(_ sender:NSButton){
        let ele = juiceTypeArr[sender.tag].juiceName
        if self.selectJuiceNames[ele] == nil||self.selectJuiceNames[ele] == 0 {
            self.selectJuiceNames[ele] = 0
        }
        else{
            self.selectJuiceNames[ele]! -= 1
        }
        getNum(self.juiceMaterialTable.view(atColumn: 0, row: sender.tag, makeIfNecessary: true)?.subviews[0] as!NSButton)

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
    
    var selectJuiceNames = Dictionary<String,Int>()
    lazy var selectJuices :Array<JuiceType> = {
        var selectJuices = Array<JuiceType>()
        for (index,juice) in juiceTypeArr.enumerated(){
            selectJuices.insert(juice, at: index)
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
        view = NSView(frame: NSRect(x: 0, y: 0, width: 225, height: 150))
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
            if(ele.value != 0){
                for juice in self.juiceTypeArr{
                    if(juice.juiceName == ele.key){
                        totalJuicePrice += Double(juice.price)! * Double(ele.value)
                        juiceNum += ele.value
                        selectJuice.append("\(ele.key):\(ele.value)|")
                    }
                }
            }
      
        }
        
        delegate.sendJuicesStringToBtn(juiceString:String(selectJuice.dropLast()),juiceNum:juiceNum,juicePrice:totalJuicePrice)

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
        view.addSubview(comfirmBtn)
        comfirmBtn.snp.makeConstraints{
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(30)
        }
        
        view.addSubview(scroll)
        scroll.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(comfirmBtn.snp.top).offset(5)

        }

    }
}

