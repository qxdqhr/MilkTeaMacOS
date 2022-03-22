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
        let book = workbook_new(path)
        let sheet = workbook_add_worksheet(book, "sheet1")
        worksheet_write_string(sheet, 0, 0, "level", nil)
        worksheet_write_string(sheet, 0, 1, "hint", nil)
        worksheet_write_string(sheet, 0, 2, "answer", nil)
        worksheet_write_string(sheet, 0, 3, "answerSize", nil)
        worksheet_write_string(sheet, 0, 4, "piecesSize", nil)

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
