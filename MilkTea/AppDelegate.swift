//
//  AppDelegate.swift
//  MilkTea
//
//  Created by tiger on 2022/2/16.
//

import Cocoa
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!

   
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application

        // WindowManager.shared.showLoginWindow()
        //初始化数据
        WindowManager.shared.showMainMenu()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }


}

