//
//  LoginProtocol.swift
//  MilkTea
//
//  Created by tiger on 2022/3/18.
//

import Foundation
@objc protocol LoginViewControllerDelegate: NSObjectProtocol{
    @objc optional  func sendUserIdtoLoginWndDelegate(username: String)
    @objc optional  func sendUserIdtoTitleBarDelegate(username: String)
    @objc optional  func sendUserIdtoWelcomeWndDelegate(username: String,userId:String)
}
