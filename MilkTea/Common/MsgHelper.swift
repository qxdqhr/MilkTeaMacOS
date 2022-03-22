//
//  AlertWnd.swift
//  MilkTea
//
//  Created by tiger on 2022/3/8.
//

import Cocoa

class MsgHelper: NSObject {
    // MARK: - 显示提示信息
   class func showMsg(message: String) {
        let alert = NSAlert()
        alert.messageText = message
        alert.window.title = "提示"
        alert.runModal()
   }
    // - MARK: - 显示查询数据窗口


}
