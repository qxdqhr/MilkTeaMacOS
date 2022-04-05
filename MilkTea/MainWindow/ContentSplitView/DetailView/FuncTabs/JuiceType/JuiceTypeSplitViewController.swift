//
//  aaa.swift
//  MilkTea
//
//  Created by tiger on 2022/2/23.
//

import Cocoa


class JuiceTypeSplitViewController: NSSplitViewController {
    // - MARK: - 控件
    //通过 detail 创建 summary 使得 summary中的数据可以再 detail 中使用
    lazy var juiceTypeDetailViewController = JuiceTypeDetailViewController()
    lazy var juiceTypeSummaryViewController = juiceTypeDetailViewController.juiceSummaryViewCtrller
    lazy var item1 = NSSplitViewItem(viewController:juiceTypeSummaryViewController)
    lazy var item2 = NSSplitViewItem(viewController:juiceTypeDetailViewController)

    @objc func pushDownJuiceTypeItemNotification(notifi:Notification){
        //收到通知
        self.splitView.setPosition(400, ofDividerAt: 0)
    }
    @objc func collapseDetailVieNotification(notifi:Notification){
        //收到通知
        self.splitViewItems.last?.isCollapsed = true
    }
    // - MARK: - 生命周期
    override func loadView() {
        view = NSView()
        view.addSubview(self.splitView)
        self.splitView.snp.makeConstraints{
            $0.size.equalToSuperview()
            $0.edges.equalToSuperview()
        }


   

        item1.canCollapse = false
        item2.isCollapsed = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(pushDownJuiceTypeItemNotification), name: pushDownJuiceTypeItem, object: nil)//创建通知
        NotificationCenter.default.addObserver(self, selector: #selector(collapseDetailVieNotification), name: collapseDetailView, object: nil)//监听通知
        
        self.addSplitViewItem(item1)
        self.addSplitViewItem(item2)
        item2.isCollapsed = true
        item1.viewController.view.snp.makeConstraints{
            $0.width.greaterThanOrEqualTo(100)
            $0.height.equalToSuperview()
            $0.top.equalToSuperview()
        }
        item2.viewController.view.snp.makeConstraints{
            $0.width.lessThanOrEqualTo(400)


        }

    }
    override func viewWillAppear() {
        JuiceTypeNetwork.refresh()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
