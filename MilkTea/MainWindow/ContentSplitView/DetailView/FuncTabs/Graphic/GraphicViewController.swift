//
//  GraphicViewController.swift
//  MilkTea
//
//  Created by tiger on 2022/2/24.
//

import Cocoa

class GraphicViewController: NSTabViewController {
    //商户:
    //默认显示自己分店的收支梯形图
    //在收支处点击查看详情 会再次出现时饼状图(某一月的详细饼状图)
    //经销商:ex
    //默认显示所有分店月度总计数据的梯形图(月度各分店总收支)
    //在收支处点击点击产看详情后显示某一分店的梯形图,收支处显示某一分店的一条数据
    //梯形图中点击显示饼状图详细数据的
    // - MARK: - 控件
    
    
    // - MARK: - 生命周期
    override func loadView() {
        view = NSView()
        #if EXOWNER
        self.addTabViewItem(NSTabViewItem(viewController: DefaultExOwnerLineChart()))
        #else
        self.addTabViewItem(NSTabViewItem(viewController: DefaultOwnerBarChart()))
        #endif
        view.addSubview(self.tabView)
        self.tabView.snp.makeConstraints{
            $0.size.equalToSuperview()
            $0.edges.equalToSuperview()
        }
     
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // - MARK: - 重写代理函数
    
    // - MARK: - 重写其他函数
    
    // - MARK: - 事件函数
    @objc func popoverAddInfoWnd(_ sender:NSButton){
        print("aa")
    }
    // - MARK: - 加入视图以及布局
    
    
}
