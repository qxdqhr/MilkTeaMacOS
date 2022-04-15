//
//  CustomerInfo.swift
//  MilkTea
//
//  Created by tiger on 2022/3/31.
//

import Foundation
class CustomerNetwork{
    class func refresh(){
        BaseNetWork.sendDataRequest(url: "http://localhost:8086/customer/refresh", method: .post, parameters: [
            "user_id":LoginUserInfo.getLoginUser().userId
        ]){ code,datas,msg in
        print(datas)
         if(code == 200){
             (((WindowManager.shared.MainWnd.contentViewController as! MainMenuViewController)
                 .contentViewControllerItem.viewController as! ContentSplitViewController)
               .detailViewController.tabViewItems[1].viewController as! CustomerInfoViewController).userInfoDataArr.removeAll()//清空数据源
             for ele in datas{
                 var customer = CustomerInfo(
                    customerName: (ele as!NSDictionary).object(forKey: "name") as! String,
                    buyingTime: (ele as!NSDictionary).object(forKey: "buying_time") as! String,
                    recentEvaluate: (ele as!NSDictionary).object(forKey: "recent_evaluate") as! String
                 )
                 customer.Id = (ele as!NSDictionary).object(forKey: "customerid") as! String
              
                 (((WindowManager.shared.MainWnd.contentViewController as! MainMenuViewController)
                     .contentViewControllerItem.viewController as! ContentSplitViewController)
                   .detailViewController.tabViewItems[1].viewController as! CustomerInfoViewController).userInfoDataArr.append(customer)//添加新数据
             }
             (((WindowManager.shared.MainWnd.contentViewController as! MainMenuViewController)
                .contentViewControllerItem.viewController as! ContentSplitViewController)
                .detailViewController.tabViewItems[1].viewController as! CustomerInfoViewController).userInfoTable.reloadData()//重载数据
            // MsgHelper.showMsg(message:"刷新成功: \(msg)")
         }
         else {
             MsgHelper.showMsg(message:"刷新失败: \(msg)")
         }
        }
    }
    class func query(para:[String:String]){
        print(para)
        BaseNetWork.sendDataRequest(url: "http://localhost:8086/customer/query", method: .post,parameters: para){ code,datas,msg in
            print("para:\(para)")
            if(code == 200){
                MsgHelper.showMsg(message:"查询成功: \(msg)")
                (((WindowManager.shared.MainWnd.contentViewController as! MainMenuViewController)
                    .contentViewControllerItem.viewController as! ContentSplitViewController)
                  .detailViewController.tabViewItems[1].viewController as! CustomerInfoViewController).userInfoDataArr.removeAll()//清空数据源
                
                for ele in datas{
                    var customer = CustomerInfo(
                        customerName: (ele as!NSDictionary).object(forKey: "name") as! String,
                        buyingTime: (ele as!NSDictionary).object(forKey: "buying_time") as! String,
                        recentEvaluate: (ele as!NSDictionary).object(forKey: "recent_evaluate") as! String
                    )
                        customer.Id = (ele as!NSDictionary).object(forKey: "customerid") as! String

                    (((WindowManager.shared.MainWnd.contentViewController as! MainMenuViewController)
                        .contentViewControllerItem.viewController as! ContentSplitViewController)
                      .detailViewController.tabViewItems[1].viewController as! CustomerInfoViewController).userInfoDataArr.append(customer)//添加新数据
                }
                (((WindowManager.shared.MainWnd.contentViewController as! MainMenuViewController)
                   .contentViewControllerItem.viewController as! ContentSplitViewController)
                 .detailViewController.tabViewItems[1].viewController as! CustomerInfoViewController).userInfoTable.reloadData()//重载数据
            }
             else {
                 MsgHelper.showMsg(message:"查询失败: \(msg)")
             }
        }
    }
}
