//
//  ExOwnerInputExpenseNetwork.swift
//  MilkTea
//
//  Created by tiger on 2022/4/5.
//

import Foundation
class ExOwnerInputExpenseNetwork{

class func refresh(){
    let controller =  (((WindowManager.shared.MainWnd.contentViewController as! MainMenuViewController)
                            .contentViewControllerItem.viewController as! ContentSplitViewController)
                          .detailViewController.tabViewItems[6].viewController as! ExOwnerInputExpensesViewController)
    
        BaseNetWork.sendDataRequest(url: "http://localhost:8086/exinexpense/refresh", method: .post, parameters: [
            "user_id":LoginUserInfo.getLoginUser().userId
        ]){ code,datas,msg in
            print(datas)
             if(code == 200){
                 controller.userInfoDataArr.removeAll()//清空数据源
                 for ele in datas{
                     var inexpense = EXOwnerInputExpenses(
                        month: (ele as!NSDictionary).object(forKey: "month") as! String,
                        totalIncome:(ele as!NSDictionary).object(forKey: "total_income") as! String,
                        totalExpence: (ele as!NSDictionary).object(forKey: "total_expence") as! String,
                        ownerId: (ele as!NSDictionary).object(forKey: "user_id") as! String
                     )
                     controller.userInfoDataArr.append(inexpense)//添加新数据
                 }
                 controller.InputExpensesTable.reloadData()//重载数据

                 MsgHelper.showMsg(message:"刷新成功: \(msg)")
            }
            else {
                MsgHelper.showMsg(message:"刷新失败: \(msg)")
            }
        }
    
    }
    class func query(para:[String:String]){
        let controller = (((WindowManager.shared.MainWnd.contentViewController as! MainMenuViewController)
                .contentViewControllerItem.viewController as! ContentSplitViewController)
            .detailViewController.tabViewItems[6].viewController as! OwnerInputExpensesViewController)
        BaseNetWork.sendDataRequest(url: "http://localhost:8086/inexpense/query", method: .post,parameters: para){ code,datas,msg in
            print("para:\(para)")
            if(code == 200){
                MsgHelper.showMsg(message:"查询成功: \(msg)")
                controller.userInfoDataArr.removeAll()//清空数据源
                
                for ele in datas{
                    let inex = OwnerInputExpenses(
                        month: (ele as!NSDictionary).object(forKey: "month") as! String,
                        totalIncome: (ele as!NSDictionary).object(forKey: "total_income") as! String,
                        totalExpence: (ele as!NSDictionary).object(forKey: "total_expence") as! String,
                        milkTeaIncome: (ele as!NSDictionary).object(forKey: "milk_tea_income") as! String,
                        milkTeaExpence: (ele as!NSDictionary).object(forKey: "milk_tea_expence") as! String,
                        fruitTeaIncome: (ele as!NSDictionary).object(forKey: "fruit_tea_income") as! String,
                        fruitTeaExpence: (ele as!NSDictionary).object(forKey: "fruit_tea_expence") as! String,
                        vegetableTeaIncome: (ele as!NSDictionary).object(forKey: "vegetable_tea_income") as! String,
                        vegetableTeaExpence: (ele as!NSDictionary).object(forKey: "vegetable_tea_expence") as! String,
                        materialExpense: (ele as!NSDictionary).object(forKey: "other_expence") as! String
                    )
              
                    
                    controller.userInfoDataArr.append(inex)//添加新数据
                }
                controller.InputExpensesTable.reloadData()//重载数据
            }
             else {
                 MsgHelper.showMsg(message:"查询失败: \(msg)")
             }
        }
    }
}
