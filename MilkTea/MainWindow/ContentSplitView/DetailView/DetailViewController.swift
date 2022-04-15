
//
//  DetailViewItem.swift
//  MilkTea
//
//  Created by tiger on 2022/2/21.
//

import Cocoa

class DetailViewController: NSTabViewController {
    lazy var funNumToController :[NSViewController] = {
        var controllers :[NSViewController]
        #if OWNER
        controllers = [
            WelcomeViewController(),       //欢迎界面
            CustomerInfoViewController(),  //顾客信息管理
            CustomerOrderViewController(), //顾客订单管理
            JuiceTypeSplitViewController(),//饮品种类管理
            JuiceMaterialViewController(), //饮品原料管理
            JuiceRankViewController(),     //饮品榜单管理
            OwnerInputExpensesViewController(), //月度收支管理
            ExcelViewController(),         //报表管理
            GraphicViewController(),       //图表管理
            AlertViewController(),         //告警信息管
            OwnerViewController(),
        ]
      
        #else
        controllers = [
            WelcomeViewController(),//欢迎界面
            WelcomeViewController(),
            WelcomeViewController(),
            JuiceTypeSplitViewController(),
            WelcomeViewController(),
            JuiceRankViewController(),
            ExOwnerInputExpensesViewController(),
            ExcelViewController(),//报表管理
            GraphicViewController(),//图表管理
            AlertViewController(),//告警信息管理
            OwnerViewController(),
        ]
        #endif
        return controllers
    }()

    
    // - MARK: - 生命周期
    override func loadView() {

        view = self.tabView
        for (_,controller) in funNumToController.enumerated() {
            let item = NSTabViewItem(viewController: controller)
            self.addTabViewItem(item)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
