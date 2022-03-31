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
    class func judgeMsg(message:String,window:NSWindow,operation:@escaping ((NSApplication.ModalResponse) -> Void)){
        let alert = NSAlert()
        alert.messageText = message
        alert.window.title = "警告"
        alert.addButton(withTitle: "OK")
        alert.addButton(withTitle: "Cancel")
        alert.alertStyle = .warning
        alert.beginSheetModal(for: window, completionHandler:operation)
    }


}
