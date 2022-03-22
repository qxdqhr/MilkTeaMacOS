//
//  Utils.swift
//  MilkTea
//
//  Created by tiger on 2022/3/9.
//

import Cocoa
//批量添加子视图
func addSubviews(targetView:NSView,views:[NSView]){
    for view in views{
        targetView.addSubview(view)
    }
}

