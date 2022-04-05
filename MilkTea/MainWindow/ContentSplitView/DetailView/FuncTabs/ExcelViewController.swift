//
//  ExcelViewController.swift
//  MilkTea
//
//  Created by tiger on 2022/2/24.
//

import Cocoa
import xlsxwriter

class ExcelViewController: NSViewController {

    // - MARK: - 数据
    let datas = [
       "顾客信息表":"CustomerInfo" ,
       "顾客订单表":"CustomerOrder" ,
       "饮品原料表":"JuiceMaterial" ,
       "月度收支表":"InputExpences" ,
       "告警信息表":"Alert" ,
       "商户信息表":"OwnerInfo"
    ]
    // - MARK: - 控件
    //设定导出路径+Label
    
    private lazy var exportExcelURLLabel = NSTextField(labelWithString: "导出报表路径")
    
    private lazy var exportExcelURL:NSButton = {
        var exportExcelURL = NSButton(title: "选择路径..", target: self, action: #selector(findURL))
        exportExcelURL.isBordered = false
        return exportExcelURL
    }()
    
    private lazy var exportExcelTypeLabel = NSTextField(labelWithString: "导出报表类型")
    
    private lazy var exportExcelType : NSComboBox = {
        var exportExcelType = NSComboBox()
        exportExcelType.usesDataSource = false
        exportExcelType.addItems(withObjectValues: datas.keys.sorted())
        exportExcelType.isEditable = false
        return exportExcelType
    }()
    private lazy var cofirmBtn = NSButton(title: "确认导出", target: self, action: #selector(exportExcel))

    // - MARK: - 生命周期
    override func loadView() {
        view = NSView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    // - MARK: - 重写代理函数
    
    // - MARK: - 其他函数
    func excelErr(){
        print("url failed")
        MsgHelper.showMsg(message: "创建报表失败")

    }
    func contentExcel(filename:String,path:String){
        var data:[Any] = []
        let book = workbook_new(path)
        let sheet = workbook_add_worksheet(book, "sheet1")
        switch filename{
        case "顾客信息表":
            data = (((WindowManager.shared.MainWnd.contentViewController as! MainMenuViewController)
                        .contentViewControllerItem.viewController as! ContentSplitViewController)
                      .detailViewController.tabViewItems[1].viewController as! CustomerInfoViewController).userInfoDataArr
            
            //title
            for (index,name) in CustomerInfo.getUIName().dropFirst().enumerated(){
                worksheet_write_string(sheet, 0, lxw_col_t(index), name, nil)
            }
            for (index,info) in data.enumerated(){
                worksheet_write_string(sheet, lxw_row_t(index+1), 0, (info as!CustomerInfo).customerName, nil)
                worksheet_write_string(sheet, lxw_row_t(index+1), 1, (info as!CustomerInfo).buyingTime, nil)
                worksheet_write_string(sheet, lxw_row_t(index+1), 2, (info as!CustomerInfo).recentEvaluate, nil)
            }
            break
        case "顾客订单表":
            data = (((WindowManager.shared.MainWnd.contentViewController as! MainMenuViewController)
            .contentViewControllerItem.viewController as! ContentSplitViewController)
          .detailViewController.tabViewItems[2].viewController as! CustomerOrderViewController).userInfoDataArr
            for (index,name) in CustomerOrder.getUIName().dropFirst().dropFirst().enumerated(){
                worksheet_write_string(sheet, 0, lxw_col_t(index), name, nil)
            }
            for (index,info) in data.enumerated(){
                worksheet_write_string(sheet, lxw_row_t(index+1), 0, (info as!CustomerOrder).customerName, nil)
                worksheet_write_string(sheet, lxw_row_t(index+1), 1, (info as!CustomerOrder).buyingjuice, nil)
                worksheet_write_string(sheet, lxw_row_t(index+1), 2, (info as!CustomerOrder).orderingTime, nil)
                worksheet_write_string(sheet, lxw_row_t(index+1), 3, (info as!CustomerOrder).juiceNumber, nil)
                worksheet_write_string(sheet, lxw_row_t(index+1), 4, (info as!CustomerOrder).totalSellingPrice, nil)
                worksheet_write_string(sheet, lxw_row_t(index+1), 5, (info as!CustomerOrder).curEvaluate, nil)
            }
            break
        case "饮品原料表":
            data = (((WindowManager.shared.MainWnd.contentViewController as! MainMenuViewController)
                .contentViewControllerItem.viewController as! ContentSplitViewController)
                        .detailViewController.tabViewItems[4].viewController as! JuiceMaterialViewController).datas
            for (index,name) in JuiceMaterial.getUIName().dropFirst().dropFirst().dropLast().enumerated(){
                worksheet_write_string(sheet, 0, lxw_col_t(index), name, nil)
            }
            for (index,info) in data.enumerated(){
                worksheet_write_string(sheet, lxw_row_t(index+1), 0, (info as!JuiceMaterial).juiceMaterialName, nil)
                worksheet_write_string(sheet, lxw_row_t(index+1), 1, (info as!JuiceMaterial).materialNumber, nil)
                worksheet_write_string(sheet, lxw_row_t(index+1), 2, (info as!JuiceMaterial).materialPerPrice, nil)
                worksheet_write_string(sheet, lxw_row_t(index+1), 3, (info as!JuiceMaterial).materialMonthBuyingTime, nil)
                worksheet_write_string(sheet, lxw_row_t(index+1), 4, (info as!JuiceMaterial).materialMonthTotalPrice, nil)
            }
            break
        case "月度收支表":
            data = (((WindowManager.shared.MainWnd.contentViewController as! MainMenuViewController)
                        .contentViewControllerItem.viewController as! ContentSplitViewController)
                        .detailViewController.tabViewItems[6].viewController as! OwnerInputExpensesViewController).userInfoDataArr
            for (index,name) in OwnerInputExpenses.getUIName().enumerated(){
                worksheet_write_string(sheet, 0, lxw_col_t(index), name, nil)
            }
            for (index,info) in data.enumerated(){
                worksheet_write_string(sheet, lxw_row_t(index+1), 0, (info as!OwnerInputExpenses).month, nil)
                worksheet_write_string(sheet, lxw_row_t(index+1), 1, (info as!OwnerInputExpenses).totalIncome, nil)
                worksheet_write_string(sheet, lxw_row_t(index+1), 2, (info as!OwnerInputExpenses).totalExpence, nil)
                worksheet_write_string(sheet, lxw_row_t(index+1), 3, (info as!OwnerInputExpenses).milkTeaIncome, nil)
                worksheet_write_string(sheet, lxw_row_t(index+1), 4, (info as!OwnerInputExpenses).milkTeaExpence, nil)
                worksheet_write_string(sheet, lxw_row_t(index+1), 5, (info as!OwnerInputExpenses).fruitTeaIncome, nil)
                worksheet_write_string(sheet, lxw_row_t(index+1), 6, (info as!OwnerInputExpenses).fruitTeaExpence, nil)
                worksheet_write_string(sheet, lxw_row_t(index+1), 7, (info as!OwnerInputExpenses).vegetableTeaIncome, nil)
                worksheet_write_string(sheet, lxw_row_t(index+1), 8, (info as!OwnerInputExpenses).vegetableTeaExpence, nil)
                worksheet_write_string(sheet, lxw_row_t(index+1), 9, (info as!OwnerInputExpenses).materialExpense, nil)
            }

            break
//        case "告警信息表":
//            data = (((WindowManager.shared.MainWnd.contentViewController as! MainMenuViewController)
//                        .contentViewControllerItem.viewController as! ContentSplitViewController)
//                      .detailViewController.tabViewItems[6].viewController as! OwnerInputExpensesViewController)

//            break
//        case "商户信息表":
//            data = (((WindowManager.shared.MainWnd.contentViewController as! MainMenuViewController)
//                        .contentViewControllerItem.viewController as! ContentSplitViewController)
//                      .detailViewController.tabViewItems[6].viewController as! OwnerInputExpensesViewController)

//            break
        default:
            let sheet = workbook_add_worksheet(book, "sheet1")
            worksheet_write_string(sheet, 0, 0, "level", nil)
            worksheet_write_string(sheet, 0, 1, "hint", nil)
            break
        }
      

        if workbook_close(book).rawValue != 0{
            excelErr()
        }
        else{
            MsgHelper.showMsg(message: "创建报表成功")
        }
    }
    // - MARK: - 事件函数
    @objc func findURL(_ sender:NSButton){
        var openPanel = NSOpenPanel()
        openPanel.canChooseDirectories = true
        if openPanel.runModal() == NSApplication.ModalResponse.OK {
            for url in openPanel.urls {
                sender.title = url.description[7...]
            }
        }
    }

    @objc func exportExcel(_ sender:NSButton){
        do{
            let filename = self.exportExcelType.stringValue
            let url = try self.exportExcelURL.title .asURL().absoluteString
       
            let creatingFullPath = url.appending("\(filename).xlsx")

            //判断是否已经创建
            contentExcel(filename:filename,path:creatingFullPath)

        }catch{
            excelErr()
        }
 
    }
    // - MARK: - 加入视图以及布局
    func setupView(){
        view.addSubview(exportExcelURLLabel)
        exportExcelURLLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(200)
            $0.centerY.equalToSuperview().offset(-150)
            $0.height.equalTo(30)
        }
        
        view.addSubview(exportExcelURL)
        exportExcelURL.snp.makeConstraints{
            $0.centerY.equalTo(exportExcelURLLabel)
            $0.leading.equalTo(exportExcelURLLabel.snp.trailing).offset(20)
//            $0.width.equalTo(550)

            $0.height.equalTo(20)
        }
        
        view.addSubview(exportExcelTypeLabel)
        exportExcelTypeLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(200)
            $0.centerY.equalToSuperview().offset(-100)
            $0.centerX.equalToSuperview()

            $0.height.equalTo(30)
        }
        
        view.addSubview(exportExcelType)
        exportExcelType.snp.makeConstraints{
            $0.leading.equalTo(exportExcelURLLabel.snp.trailing)
            $0.centerY.equalTo(exportExcelTypeLabel)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(30)
        }
        view.addSubview(cofirmBtn)
        cofirmBtn.snp.makeConstraints{
            $0.leading.equalTo(exportExcelURLLabel.snp.trailing)
            $0.centerY.equalToSuperview().offset(-50)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(150)
            $0.height.equalTo(30)
        }
        
    }
    
}

