//
//  LoginWindowController.swift
//  MilkTea
//
//  Created by tiger on 2022/2/16.
//

import Cocoa

class LRWindowController: NSWindowController {

    // - MARK: - 创建窗口
    private lazy var loginRegisterWnd: NSWindow = {
        var wnd = NSWindow(contentRect: CGRect(x: 0, y: 0, width: 0, height: 0), styleMask: [NSWindow.StyleMask.titled,NSWindow.StyleMask.resizable,NSWindow.StyleMask.closable], backing: NSWindow.BackingStoreType.buffered, defer: false)
        
        wnd.titlebarAppearsTransparent = true
        wnd.isMovableByWindowBackground = true
        
        
        wnd.contentMinSize = NSSize(width: 500, height: 500)
        wnd.contentMaxSize = NSSize(width: 500, height: 500)
        wnd.title = "员工登录"
        wnd.windowController = self
        return wnd
        
    }()
    // - MARK: - 重写 init
    override init (window:NSWindow?){
        super.init(window: window)
        self.window = loginRegisterWnd
        self.window?.isReleasedWhenClosed = false
        self.window?.center()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // - MARK: - 重写其他函数
    
    // - MARK: - 事件函数


}
