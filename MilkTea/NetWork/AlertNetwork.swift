//
//  AlterNetwork.swift
//  MilkTea
//
//  Created by tiger on 2022/4/3.
//

import Foundation
class AlertNetwork{
#if OWNER
    class func refresh(){
        let ViewController = (((WindowManager.shared.MainWnd.contentViewController as! MainMenuViewController)
            .contentViewControllerItem.viewController as! ContentSplitViewController)
            .detailViewController.tabViewItems[9].viewController as! AlertViewController)
        BaseNetWork.sendDataRequest(url: "http://localhost:8086/alert/refresh", method: .post, parameters: [
            "alert_owner":LoginUserInfo.getLoginUser().userId
        ]){ code,datas,msg in
        print(datas)
         if(code == 200){
             for ele in datas{
                 let alert = Alert(
                    Id:(ele as!NSDictionary).object(forKey: "id") as! String,
                    alertReason:(ele as!NSDictionary).object(forKey: "alert_reason") as! String,
                    alertMethod:(ele as!NSDictionary).object(forKey: "alert_method") as! String,
                    alertOwner: (ele as!NSDictionary).object(forKey: "alert_owner") as! String,
                    alertExOwner:(ele as!NSDictionary).object(forKey: "alert_ex_owner") as! String,
                    alertTime:(ele as!NSDictionary).object(forKey: "alert_time") as! String,
                    alertReceived: (ele as!NSDictionary).object(forKey: "alert_time") as! String
                 )
                 if alert.alertReceived == "未接受"{
                     MsgHelper.showMsg(message:"您有新的告警,请查收")
                 }
                 ViewController.alertMethodTextField.stringValue = alert.alertMethod == "" ? "目前未收到告警":alert.alertMethod
                 ViewController.alertReasonTextField.stringValue = alert.alertReason == "" ? "目前未收到告警":alert.alertReason
//                 ViewController.alertMethodTextField.stringValue = alert.alertExOwner
                 ViewController.alertTimeTextField.stringValue = alert.alertTime == "" ? "目前未收到告警":alert.alertTime

             }
             MsgHelper.showMsg(message:"刷新成功: \(msg)")
         }
         else {
             MsgHelper.showMsg(message:"刷新失败: \(msg)")
         }
        }
    }
    class func receiveAlert(){
        let ViewController = (((WindowManager.shared.MainWnd.contentViewController as! MainMenuViewController)
            .contentViewControllerItem.viewController as! ContentSplitViewController)
            .detailViewController.tabViewItems[9].viewController as! AlertViewController)
        BaseNetWork.sendDataRequest(url: "http://localhost:8086/alert/receive", method: .post, parameters: [
            "alert_owner":LoginUserInfo.getLoginUser().userId,
            "alert_reason":ViewController.alertReasonTextField.stringValue,
            "alert_time":ViewController.alertTimeTextField.stringValue,
        ]){ code,datas,msg in
        print(datas)
         if(code == 200){
             ViewController.alertMethodTextField.stringValue = "目前未收到告警"
             ViewController.alertReasonTextField.stringValue = "目前未收到告警"
             ViewController.alertTimeTextField.stringValue = "目前未收到告警"
             MsgHelper.showMsg(message:"确认收到成功: \(msg)")
         }
         else {
             MsgHelper.showMsg(message:"确认收到失败: \(msg)")
         }
        }
    }
#endif
    class func add(para:Alert){
        print(para)
   

        BaseNetWork.sendDataRequest(url: "http://localhost:8086/alert/exOwner/add", method: .post, parameters: [
            "id":para.Id,
            "alert_time":para.alertTime,
            "alert_reason":para.alertReason,
            "alert_method":para.alertMethod,
            "alert_owner":para.alertOwner,
            "alert_ex_owner":para.alertExOwner,
            "alert_received":para.alertReceived,
        ]){ code,data,msg in
            print("para:\(para)")
             if(code == 200){
                 MsgHelper.showMsg(message:"发送告警成功")
        
             }
             else {
                 MsgHelper.showMsg(message:"发送告警失败: \(msg)")
             }
        }
    }
}
