////
////  JuiceRankNetwork.swift
////  MilkTea
////
////  Created by tiger on 2022/4/3.
////
//
//import Foundation
//class JuiceRankNetwork{
//    class func refresh(){
//       
//        BaseNetWork.sendDataRequest(url: "http://localhost:8086/juice/refresh", method: .post, parameters: [
//            "userid":LoginUserInfo.getLoginUser().userId
//        ]){ code,datas,msg in
//        print(datas)
//         if(code == 200){
//             (((WindowManager.shared.MainWnd.contentViewController as! MainMenuViewController)
//                             .contentViewControllerItem.viewController as! ContentSplitViewController)
//                           .detailViewController.tabViewItems[3].viewController as! JuiceTypeSplitViewController)
//                             .juiceTypeDetailViewController.juiceSummaryViewCtrller.data.removeAll()//清空数据源
//             for ele in datas{
//                 let juice = JuiceType(
//                    juiceName: (ele as!NSDictionary).object(forKey: "juice_name") as! String,
//                    juiceType: (ele as!NSDictionary).object(forKey: "juice_type") as! String,
//                    lastOrderingTime: (ele as!NSDictionary).object(forKey: "last_ordering_time") as! String,
//                    price: (ele as!NSDictionary).object(forKey: "price") as! String,
//                    profit: (ele as!NSDictionary).object(forKey: "profit") as! String,
//                    cost: (ele as!NSDictionary).object(forKey: "cost") as! String,
//                    curEvaluate: (ele as!NSDictionary).object(forKey: "cur_evaluate") as! String
//                 )
//                 juice.juiceId = (ele as!NSDictionary).object(forKey: "id") as! String
//              
//                 (((WindowManager.shared.MainWnd.contentViewController as! MainMenuViewController)
//                                 .contentViewControllerItem.viewController as! ContentSplitViewController)
//                               .detailViewController.tabViewItems[3].viewController as! JuiceTypeSplitViewController)
//                                 .juiceTypeDetailViewController.juiceSummaryViewCtrller.data.append(juice)//添加新数据
//                 
//            
//             }
//             (((WindowManager.shared.MainWnd.contentViewController as! MainMenuViewController)
//                             .contentViewControllerItem.viewController as! ContentSplitViewController)
//                           .detailViewController.tabViewItems[3].viewController as! JuiceTypeSplitViewController)
//                             .juiceTypeDetailViewController.juiceSummaryViewCtrller.collectionView.reloadData()//重载数据
//            // MsgHelper.showMsg(message:"刷新成功: \(msg)")
//         }
//         else {
//             MsgHelper.showMsg(message:"刷新失败: \(msg)")
//         }
//        }
//    }
//}
