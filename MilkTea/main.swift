//
//  File.swift
//  ControlTest
//
//  Created by tiger on 2022/2/15.
//

import AppKit
func addMenu() -> NSMenu{
    //1 根菜单
    let mainMenu = NSMenu()
//    //2 第一个主菜单项
//    var menuItem1 = NSMenuItem()
//    //3 主菜单项的下属菜单
//    var submenu1 = NSMenu(title: "aaa")
//    //4 主菜单项的下属菜单的菜单项
//    let aboutMenuItem = NSMenuItem(title: "About", action: #selector(NSApplication.orderFrontStandardAboutPanel(_:)), keyEquivalent: "A")
//    let helpMenuItem = NSMenuItem(title: "Help", action: nil, keyEquivalent: "H")
//    let quitMenuItem = NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "Q")
//    //4 -> 3
//    submenu1.addItem(aboutMenuItem)
//    submenu1.addItem(helpMenuItem)
//    submenu1.addItem(quitMenuItem)
//    //3 -> 2
//    menuItem1.submenu = submenu1
//    
//    //2 第二个主菜单项
//    var menuItem2 = NSMenuItem()
//    var menu2 = NSMenu(title: "bbb")
//    //4 主菜单项的下属菜单的菜单项
//    let aboutMenuItem2 = NSMenuItem(title: "About", action: #selector(NSApplication.orderFrontStandardAboutPanel(_:)), keyEquivalent: "A")
//    let quitMenuItem2 = NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "Q")
//    
//    let menuItem2_1 = NSMenuItem()
//    var menu2_1 = NSMenu(title: "ttt")
//    let quitMenuItem3 = NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "Q")
//    menuItem2_1.submenu = menu2_1
//    menu2_1.addItem(quitMenuItem3)
//    //4 -> 3
//    menu2.addItem(aboutMenuItem2)
//    menu2.addItem(quitMenuItem2)
//    menu2.addItem(menuItem2_1)
//    //3 -> 2
//    menuItem2.submenu = menu2
//    
//    //根菜单的菜单项 添加到 根菜单
//    mainMenu.addItem(menuItem1)
//    mainMenu.addItem(menuItem2)

    return mainMenu
}

autoreleasepool {
    let app = NSApplication.shared
    let appDeleagte = AppDelegate()
    app.delegate = appDeleagte
    app.mainMenu = addMenu()
    app.run()
}
