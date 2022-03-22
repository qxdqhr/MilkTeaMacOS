//
//  RegisterProtocol.swift
//  MilkTea
//
//  Created by tiger on 2022/3/18.
//

import Foundation
protocol RegisterViewControllerDelegate: NSObjectProtocol{
    func sendUserIddelegate(userid: String,password:String) 
}
