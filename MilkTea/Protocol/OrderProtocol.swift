//
//  File.swift
//  MilkTea
//
//  Created by tiger on 2022/3/21.
//

import Foundation
@objc protocol OrderViewControllerDelegate: NSObjectProtocol{
    @objc optional  func sendTimeStringToBtn(timeString: String)
    @objc optional  func sendJuicesStringToBtn(juiceString: String,juiceNum:Int,juicePrice:Double) 


}
