//
//  JuiceNetwork.swift
//  MilkTea
//
//  Created by tiger on 2022/4/3.
//

import Foundation
class JuiceTypeNetwork{
#if OWNER
    class func refresh(){
        let summaryViewController = (((WindowManager.shared.MainWnd.contentViewController as! MainMenuViewController)
                        .contentViewControllerItem.viewController as! ContentSplitViewController)
                      .detailViewController.tabViewItems[3].viewController as! JuiceTypeSplitViewController)
                        .juiceTypeDetailViewController.juiceSummaryViewCtrller
        let orderJuiceSelection = ((((WindowManager.shared.MainWnd.contentViewController as! MainMenuViewController)
            .contentViewControllerItem.viewController as! ContentSplitViewController)
            .detailViewController.tabViewItems[2].viewController as! CustomerOrderViewController)
            .popoverAddOrder.contentViewController as! AddOrderViewController)
            .juiceSelePopOver.contentViewController as! JuiceSeleTableViewController
        
        var juiceRankController = (((WindowManager.shared.MainWnd.contentViewController as! MainMenuViewController)
            .contentViewControllerItem.viewController as! ContentSplitViewController)
            .detailViewController.tabViewItems[5].viewController as! JuiceRankViewController)
                               
        BaseNetWork.sendDataRequest(url: "http://localhost:8086/juice/refresh", method: .post, parameters: [
            "user_id":LoginUserInfo.getLoginUser().userId
        ]){ code,datas,msg in
        print(LoginUserInfo.getLoginUser().userId)
         if(code == 200){
             summaryViewController.data.removeAll()//清空数据源
             orderJuiceSelection.juiceTypeArr.removeAll()//清空数据源
             for ele in datas{
                 let juice = JuiceType(
                    juiceName: (ele as!NSDictionary).object(forKey: "juice_name") as! String,
                    juiceType: (ele as!NSDictionary).object(forKey: "juice_type") as! String,
                    lastOrderingTime: (ele as!NSDictionary).object(forKey: "last_ordering_time") as! String,
                    price: (ele as!NSDictionary).object(forKey: "price") as! String,
                    profit: (ele as!NSDictionary).object(forKey: "profit") as! String,
                    cost: (ele as!NSDictionary).object(forKey: "cost") as! String,
                    curEvaluate: (ele as!NSDictionary).object(forKey: "cur_evaluate") as! String,
                    juiceSoldNumber: (ele as!NSDictionary).object(forKey: "juice_sold_number") as! String,
                    sellingTotalPrice: (ele as!NSDictionary).object(forKey: "selling_total_price") as! String,
                    goodEvaluateNum: (ele as!NSDictionary).object(forKey: "good_evaluate_num") as! String
                 )
                 juice.juiceId = (ele as!NSDictionary).object(forKey: "id") as! String
                 summaryViewController.data.append(juice)//添加新数据
                 orderJuiceSelection.juiceTypeArr.append(juice)

             }
      
             summaryViewController.collectionView.reloadData()//重载数据
             orderJuiceSelection.juiceMaterialTable.reloadData()

             for data in summaryViewController.data{
                 var juiceRank = JuiceRank(
                     juiceName:data.juiceName,
                     juiceSoldNumber:data.juiceSoldNumber,
                     sellingTotalPrice: data.sellingTotalPrice,
                     goodEvaluateNum: data.goodEvaluateNum
                 )
                 juiceRankController.juiceRankArr.append(juiceRank)
             }
             juiceRankController.juiceRankTable.reloadData()
            // MsgHelper.showMsg(message:"刷新成功: \(msg)")
         }
         else {
             MsgHelper.showMsg(message:"刷新失败: \(msg)")
         }
        }
    }
#endif
#if EXOWNER
    class func refresh(){
        let summaryViewController = (((WindowManager.shared.MainWnd.contentViewController as! MainMenuViewController)
                        .contentViewControllerItem.viewController as! ContentSplitViewController)
                      .detailViewController.tabViewItems[3].viewController as! JuiceTypeSplitViewController)
                        .juiceTypeDetailViewController.juiceSummaryViewCtrller

        
        var juiceRankController = (((WindowManager.shared.MainWnd.contentViewController as! MainMenuViewController)
            .contentViewControllerItem.viewController as! ContentSplitViewController)
            .detailViewController.tabViewItems[5].viewController as! JuiceRankViewController)
                               
        BaseNetWork.sendDataRequest(url: "http://localhost:8086/juice/exowner/refresh", method: .post, parameters: [
            "user_id":LoginUserInfo.getLoginUser().userId
        ]){ code,datas,msg in
        print(LoginUserInfo.getLoginUser().userId)
         if(code == 200){
             summaryViewController.data.removeAll()//清空数据源
             for ele in datas{
                 let juice = JuiceType(
                    juiceName: (ele as!NSDictionary).object(forKey: "juice_name") as! String,
                    juiceType: (ele as!NSDictionary).object(forKey: "juice_type") as! String,
                    lastOrderingTime: (ele as!NSDictionary).object(forKey: "last_ordering_time") as! String,
                    price: (ele as!NSDictionary).object(forKey: "price") as! String,
                    profit: (ele as!NSDictionary).object(forKey: "profit") as! String,
                    cost: (ele as!NSDictionary).object(forKey: "cost") as! String,
                    curEvaluate: (ele as!NSDictionary).object(forKey: "cur_evaluate") as! String,
                    juiceSoldNumber: (ele as!NSDictionary).object(forKey: "juice_sold_number") as! String,
                    sellingTotalPrice: (ele as!NSDictionary).object(forKey: "selling_total_price") as! String,
                    goodEvaluateNum: (ele as!NSDictionary).object(forKey: "good_evaluate_num") as! String
                 )
                 juice.juiceId = (ele as!NSDictionary).object(forKey: "id") as! String
                 summaryViewController.data.append(juice)//添加新数据

             }
      
             summaryViewController.collectionView.reloadData()//重载数据

             for data in summaryViewController.data{
                 var juiceRank = JuiceRank(
                     juiceName:data.juiceName,
                     juiceSoldNumber:data.juiceSoldNumber,
                     sellingTotalPrice: data.sellingTotalPrice,
                     goodEvaluateNum: data.goodEvaluateNum
                 )
                 juiceRankController.juiceRankArr.append(juiceRank)
             }
             juiceRankController.juiceRankTable.reloadData()
            // MsgHelper.showMsg(message:"刷新成功: \(msg)")
         }
         else {
             MsgHelper.showMsg(message:"刷新失败: \(msg)")
         }
        }
    }
#endif
}
