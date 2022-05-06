//
//  OwnerNetwork.swift
//  MilkTea
//
//  Created by tiger on 2022/4/6.
//

import Foundation
class OwnerNetwork{
    class func delete(para:[String:String]){
        print(para)
        BaseNetWork.sendDataRequest(url: "http://localhost:8086/owner/delete", method: .post,parameters: para){ code,datas,msg in
            print("para:\(para)")
            if(code == 200){
                MsgHelper.showMsg(message:"刷新成功: \(msg)")
                self.refresh()
            }
             else {
                 MsgHelper.showMsg(message:"删除失败: \(msg)")
             }
        }
    }
    class func refresh(){
        BaseNetWork.sendDataRequest(url: "http://localhost:8086/owner/refresh", method: .post, parameters: [
            "ex_owner_userid":LoginUserInfo.getLoginUser().userId
        ]){ code,datas,msg in
        print(datas)
         if(code == 200){
             (((WindowManager.shared.MainWnd.contentViewController as! MainMenuViewController)
                 .contentViewControllerItem.viewController as! ContentSplitViewController)
                .detailViewController.tabViewItems[10].viewController as! OwnerViewController).userInfoDataArr.removeAll()//清空数据源
             for ele in datas{
                 var order = OwnerInfo(
                    ownerId:  (ele as!NSDictionary).object(forKey: "user_id") as! String,
                    alertTimes: String((ele as!NSDictionary).object(forKey: "alert_times") as! Int),
                    recentAlertReason: (ele as!NSDictionary).object(forKey: "recent_reason") as! String
                 )
            
                 (((WindowManager.shared.MainWnd.contentViewController as! MainMenuViewController)
                     .contentViewControllerItem.viewController as! ContentSplitViewController)
                   .detailViewController.tabViewItems[10].viewController as! OwnerViewController).userInfoDataArr.append(order)//添加新数据
                
             }
             (((WindowManager.shared.MainWnd.contentViewController as! MainMenuViewController)
                .contentViewControllerItem.viewController as! ContentSplitViewController)
                .detailViewController.tabViewItems[10].viewController as! OwnerViewController).userInfoTable.reloadData()//重载数据
    
             MsgHelper.showMsg(message:"刷新成功: \(msg)")
         }
         else {
             MsgHelper.showMsg(message:"刷新失败: \(msg)")
         }
        }
    }
}
