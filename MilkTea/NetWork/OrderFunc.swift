//
//  OrderFunc.swift
//  MilkTea
//
//  Created by tiger on 2022/3/30.
//

import Foundation
class OrderFunc{
    class func refresh(){
        BaseNetWork.sendDataRequest(url: "http://localhost:8086/order/refresh", method: .post, parameters: [
            "userid":LoginUserInfo.getLoginUser().userId
        ]){ code,datas,msg in
        print(datas)
         if(code == 200){
             (((WindowManager.shared.MainWnd.contentViewController as! MainMenuViewController)
                 .contentViewControllerItem.viewController as! ContentSplitViewController)
               .detailViewController.tabViewItems[2].viewController as! CustomerOrderViewController).userInfoDataArr.removeAll()//清空数据源
             for ele in datas{
                 var order = CustomerOrder(
                   customerName: (ele as!NSDictionary).object(forKey: "customerid") as! String,
                   buyingjuice: (ele as!NSDictionary).object(forKey: "buyingjuice") as! String,
                   orderingTime: (ele as!NSDictionary).object(forKey: "orderingtime") as! String,
                   juiceNumber: (ele as!NSDictionary).object(forKey: "juicenumber") as! String,
                   totalSellingPrice: (ele as!NSDictionary).object(forKey: "totalsellingprice") as! String,
                   curEvaluate: (ele as!NSDictionary).object(forKey: "curevaluate") as! String
                   )
                  order.orderId = (ele as!NSDictionary).object(forKey: "orderid") as! String

                 (((WindowManager.shared.MainWnd.contentViewController as! MainMenuViewController)
                     .contentViewControllerItem.viewController as! ContentSplitViewController)
                   .detailViewController.tabViewItems[2].viewController as! CustomerOrderViewController).userInfoDataArr.append(order)//添加新数据
                
             }
             (((WindowManager.shared.MainWnd.contentViewController as! MainMenuViewController)
                .contentViewControllerItem.viewController as! ContentSplitViewController)
              .detailViewController.tabViewItems[2].viewController as! CustomerOrderViewController).userOrderTable.reloadData()//重载数据
    
             MsgHelper.showMsg(message:"刷新成功: \(msg)")
         }
         else {
             MsgHelper.showMsg(message:"刷新失败: \(msg)")
         }
        }
    }
    class func modify(para:[String:String]){
        print("para:\(para)")
        BaseNetWork.sendDataRequest(url: "http://localhost:8086/order/modify", method: .post, parameters:para ){ code,datas,msg in
            print(datas)
             if(code == 200){
                 MsgHelper.showMsg(message:"修改成功")
                 OrderFunc.refresh()
             }
             else {
                 MsgHelper.showMsg(message:"修改失败: \(msg)")
             }
     
        }
    }
    class func add(para:CustomerOrder){
        print(para)
        BaseNetWork.sendModelDataRequest(url: "http://localhost:8086/order/add", method: .post, parameters: para){ code,data,msg in
            print("para:\(para)")
             if(code == 200){
                 MsgHelper.showMsg(message:"数据添加成功")
                 //确定后自动刷新
                 OrderFunc.refresh()
             }
             else {
                 MsgHelper.showMsg(message:"数据添加失败: \(msg)")
             }
        }
    }
    class func query(para:[String:String]){
        print(para)
        BaseNetWork.sendDataRequest(url: "http://localhost:8086/order/query", method: .post,parameters: para){ code,datas,msg in
            print("para:\(para)")
            if(code == 200){
                MsgHelper.showMsg(message:"查询成功: \(msg)")
                (((WindowManager.shared.MainWnd.contentViewController as! MainMenuViewController)
                    .contentViewControllerItem.viewController as! ContentSplitViewController)
                  .detailViewController.tabViewItems[2].viewController as! CustomerOrderViewController).userInfoDataArr.removeAll()//清空数据源
                
                for ele in datas{
                    var order = CustomerOrder(
                      customerName: (ele as!NSDictionary).object(forKey: "customerid") as! String,
                      buyingjuice: (ele as!NSDictionary).object(forKey: "buyingjuice") as! String,
                      orderingTime: (ele as!NSDictionary).object(forKey: "orderingtime") as! String,
                      juiceNumber: (ele as!NSDictionary).object(forKey: "juicenumber") as! String,
                      totalSellingPrice: (ele as!NSDictionary).object(forKey: "totalsellingprice") as! String,
                      curEvaluate: (ele as!NSDictionary).object(forKey: "curevaluate") as! String
                      )
                    order.orderId = (ele as!NSDictionary).object(forKey: "orderid") as! String

                    (((WindowManager.shared.MainWnd.contentViewController as! MainMenuViewController)
                        .contentViewControllerItem.viewController as! ContentSplitViewController)
                      .detailViewController.tabViewItems[2].viewController as! CustomerOrderViewController).userInfoDataArr.append(order)//添加新数据
                }
                (((WindowManager.shared.MainWnd.contentViewController as! MainMenuViewController)
                   .contentViewControllerItem.viewController as! ContentSplitViewController)
                 .detailViewController.tabViewItems[2].viewController as! CustomerOrderViewController).userOrderTable.reloadData()//重载数据
            }
             else {
                 MsgHelper.showMsg(message:"查询失败: \(msg)")
             }
        }
    }
    
    class func delete(para:[String:String]){
        print(para)
        BaseNetWork.sendDataRequest(url: "http://localhost:8086/order/delete", method: .post,parameters: para){ code,datas,msg in
            print("para:\(para)")
            if(code == 200){
                MsgHelper.showMsg(message:"删除成功: \(msg)")
                (((WindowManager.shared.MainWnd.contentViewController as! MainMenuViewController)
                    .contentViewControllerItem.viewController as! ContentSplitViewController)
                  .detailViewController.tabViewItems[2].viewController as! CustomerOrderViewController).userInfoDataArr.removeAll()//清空数据源
                
                for ele in datas{
                    var order = CustomerOrder(
                      customerName: (ele as!NSDictionary).object(forKey: "customerid") as! String,
                      buyingjuice: (ele as!NSDictionary).object(forKey: "buyingjuice") as! String,
                      orderingTime: (ele as!NSDictionary).object(forKey: "orderingtime") as! String,
                      juiceNumber: (ele as!NSDictionary).object(forKey: "juicenumber") as! String,
                      totalSellingPrice: (ele as!NSDictionary).object(forKey: "totalsellingprice") as! String,
                      curEvaluate: (ele as!NSDictionary).object(forKey: "curevaluate") as! String
                      )
                    order.orderId = (ele as!NSDictionary).object(forKey: "orderid") as! String

                    (((WindowManager.shared.MainWnd.contentViewController as! MainMenuViewController)
                        .contentViewControllerItem.viewController as! ContentSplitViewController)
                      .detailViewController.tabViewItems[2].viewController as! CustomerOrderViewController).userInfoDataArr.append(order)//添加新数据
                }
                (((WindowManager.shared.MainWnd.contentViewController as! MainMenuViewController)
                   .contentViewControllerItem.viewController as! ContentSplitViewController)
                 .detailViewController.tabViewItems[2].viewController as! CustomerOrderViewController).userOrderTable.reloadData()//重载数据
            }
             else {
                 MsgHelper.showMsg(message:"删除失败: \(msg)")
             }
        }
    }
    
}

