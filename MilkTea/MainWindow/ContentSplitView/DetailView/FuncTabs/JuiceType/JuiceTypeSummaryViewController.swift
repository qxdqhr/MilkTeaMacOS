//
//  JuiceTypeSummaryView.swift
//  MilkTea
//
//  Created by tiger on 2022/3/9.
//

import Cocoa
class JuiceTypeSummaryViewController: NSViewController,NSCollectionViewDataSource,NSCollectionViewDelegate {
    var data  = [
            JuiceType(juiceName: "aaa", juiceType: "a", lastOrderingTime: "a", price: "10.0", profit: "a", cost: "a", curEvaluate: "a"),

            JuiceType(juiceName: "bbb", juiceType: "a", lastOrderingTime: "a", price: "15.2", profit: "a", cost: "a", curEvaluate: "a"),
            JuiceType(juiceName: "ccc", juiceType: "a", lastOrderingTime: "a", price: "13.2", profit: "a", cost: "a", curEvaluate: "a"),
            JuiceType(juiceName: "ddd", juiceType: "a", lastOrderingTime: "a", price: "9.9", profit: "a", cost: "a", curEvaluate: "a"),
    ]
    
    lazy var scrollView: NSScrollView = {
        let view = NSScrollView()
        view.hasHorizontalScroller = true
        view.documentView = self.collectionView
        return view
    }()
    private lazy var collectionView: NSCollectionView = {
        var ctrl = NSCollectionView()
        ctrl.delegate = self
        ctrl.dataSource = self
        ctrl.collectionViewLayout = flowLayout
        ctrl.isSelectable = true

        ctrl.register(JuiceTypeSummaryViewItem.self, forItemWithIdentifier: .identifier)
        return ctrl
    }()
    // CollectionView 的 布局控件 新版本
    private lazy var flowLayout : NSCollectionViewFlowLayout = {
        let layout = NSCollectionViewFlowLayout()
        layout.itemSize = NSMakeSize(150, 150)
        layout.scrollDirection = NSCollectionView.ScrollDirection.vertical
//        layout.minimumLineSpacing = 10  //item 之间的纵向间距
        layout.minimumInteritemSpacing = 0 //item 之间的横向间距
        //所有 item 与
        layout.sectionInset.top = 10 //
        return layout
    }()
    
    override func loadView() {
        view = NSView()
        setupView()
    }
    func detailData() -> [JuiceType]{
        return self.data
    }
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        //选中 Item 展开侧边栏
        var juiceName = (collectionView.item(at: indexPaths.first!) as! JuiceTypeSummaryViewItem).lblName.stringValue
        NotificationCenter.default.post(name: pushDownJuiceTypeItem, object: juiceName)

    }
    func collectionView(_ collectionView: NSCollectionView, didDeselectItemsAt indexPaths: Set<IndexPath>) {
        //不在选中,收起侧边栏
        //发送 收起 detail 通知
        NotificationCenter.default.post(name: collapseDetailView, object: nil)
    }
    // - MARK: - 加入视图以及布局
    func setupView(){
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
            $0.size.greaterThanOrEqualToSuperview()

        }
        
    }
    //代理数据源函数
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count

    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: .identifier, for: indexPath)
        item.representedObject = self.data[indexPath.item]

        return item
    }

}
