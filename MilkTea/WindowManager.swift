//
//  WindowManager.swift
//  MilkTea
//
//  Created by tiger on 2022/2/16.
//

import Cocoa

final class WindowManager {
    static let shared = WindowManager()

    lazy var LRWnd:LRWindowController = { //防止循环调用 懒加载
        var LRWnd = LRWindowController()
        LRWnd.contentViewController = LRViewController()
        return LRWnd
    }()
    lazy var MainWnd :MainMenuWindowController = {
        var MainWnd = MainMenuWindowController()
        MainWnd.contentViewController = MainMenuViewController()
        return MainWnd
    }()
    
    func showLoginWindow (){
        LRWnd.showWindow(self)
    }
    func showMainMenu(){
        MainWnd.showWindow(self)
    }
    private init() {

    }
//    class func shared() -> WindowManager {
//           return windowManager
//    }
}
