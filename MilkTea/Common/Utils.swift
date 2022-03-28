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
class LoginUserInfo{
    static let userDefault = UserDefaults.standard
    //设置登录用户名
    class func setLoginUser(userName:String, userId:String){
        userDefault.set(userId, forKey: "userid")
        userDefault.set(userName, forKey: "userName")
    }
    class func removeLoginUser(){
        userDefault.removeObject(forKey: "userid")
        userDefault.removeObject(forKey: "userName")
    }
    class func getLoginUser() -> (userName:String, userId:String){
        return (userDefault.string(forKey: "userName") ?? "aaa",userDefault.string(forKey: "userid") ?? "aaa")
    }
    

}

