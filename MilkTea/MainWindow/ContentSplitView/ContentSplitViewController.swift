//
//  C.swift
//  MilkTea
//
//  Created by tiger on 2022/2/28.
//

import AppKit
class ContentSplitViewController:NSSplitViewController{
    lazy var functionBarViewController = FunctionBarViewController()
    lazy var detailViewController = functionBarViewController.outLineView.detailPages
    override func loadView() {
        view = NSView()
        view.addSubview(self.splitView)
        self.splitView.snp.makeConstraints{
            $0.size.equalToSuperview()
            $0.edges.equalToSuperview()
        }
    
    
        let item1 = NSSplitViewItem(viewController:functionBarViewController)
        item1.canCollapse = false
        
        let item2 = NSSplitViewItem(viewController:detailViewController)
        item2.canCollapse = false

        self.splitView.isVertical = true
        
        self.addSplitViewItem(item1)
        self.addSplitViewItem(item2)
        item1.viewController.view.snp.makeConstraints{
            $0.width.lessThanOrEqualTo(300)
            $0.height.equalToSuperview()
            $0.top.equalToSuperview()
        }
  
        item2.viewController.view.snp.makeConstraints{
            $0.width.equalToSuperview()
            $0.height.greaterThanOrEqualTo(550)
            $0.top.equalToSuperview()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
