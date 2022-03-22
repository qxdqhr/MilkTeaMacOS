//
//  MainMenuViewController.swift
//  MilkTea
//
//  Created by tiger on 2022/2/21.
//

import Cocoa

class MainMenuViewController: NSSplitViewController,LoginViewControllerDelegate {

    func sendUserIdtoTitleBarDelegate(username: String){
        (titleBarViewControllerItem.viewController as! TitleBarController).userBtn.title = username
    }

    // - MARK: - 控件
    
    var titleBarViewControllerItem = NSSplitViewItem(viewController: TitleBarController())
    
    var contentViewControllerItem = NSSplitViewItem(viewController: ContentSplitViewController())

    // - MARK: - 生命周期
    override func loadView() {
        view = self.splitView
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        splitView.isVertical = false
        addSplitViewItem(titleBarViewControllerItem)
        addSplitViewItem(contentViewControllerItem)
        titleBarViewControllerItem.viewController.view.snp.makeConstraints{
            $0.height.equalTo(50)
        }
        contentViewControllerItem.viewController.view.snp.makeConstraints{
            $0.height.greaterThanOrEqualTo(550)
        }
        setupView()
    }
    // - MARK: - 重写代理函数
    
    // - MARK: - 重写其他函数
    
    // - MARK: - 事件函数
    
    // - MARK: - 加入视图以及布局
    func setupView(){

    }

}
