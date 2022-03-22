//
//  BaseFuncViewCntroller.swift
//  MilkTea
//
//  Created by tiger on 2022/3/1.
//

import AppKit

class BaseFuncViewController: NSViewController,NSTableViewDelegate,NSTableViewDataSource {

    // - MARK: - 控件
    private var addInfoBtn = NSButton()
    private var queryInfoBtn = NSSearchField()
    private lazy var table : NSTableView = {
        var userInfoTable = NSTableView()
        userInfoTable.delegate = self
        userInfoTable.dataSource = self
        userInfoTable.usesAlternatingRowBackgroundColors = true
        userInfoTable.allowsColumnResizing = true
        return userInfoTable
    }()
    private lazy var scroll:NSScrollView = {
       var scroll = NSScrollView()
        scroll.documentView = self.table
        scroll.hasVerticalScroller = true
        scroll.autohidesScrollers = true
        
        return scroll
    }()
    // - MARK: - 生命周期
    override func loadView() {
        view = NSView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // - MARK: - 加入视图以及布局
    func setupView(){
        view.addSubview(addInfoBtn)
        addInfoBtn.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
            $0.width.equalTo(100)
            $0.height.equalTo(30)
        }
        
        view.addSubview(queryInfoBtn)
        queryInfoBtn.snp.makeConstraints{
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview()
            $0.width.equalTo(150)
            $0.height.equalTo(30)
        }
        view.addSubview(scroll)
        scroll.snp.makeConstraints{
            $0.top.equalTo(queryInfoBtn.snp.bottom)
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
    }
    
}
