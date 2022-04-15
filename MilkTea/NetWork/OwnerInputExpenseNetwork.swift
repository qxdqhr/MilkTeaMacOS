//
//  InputExpenseNetwork.swift
//  MilkTea
//
//  Created by tiger on 2022/4/3.
//

import Foundation
class OwnerInputExpenseNetwork{
    class func refresh(){
        let controller =  (((WindowManager.shared.MainWnd.contentViewController as! MainMenuViewController)
                                .contentViewControllerItem.viewController as! ContentSplitViewController)
                              .detailViewController.tabViewItems[6].viewController as! OwnerInputExpensesViewController)
        
        BaseNetWork.sendDataRequest(url: "http://localhost:8086/inexpense/refresh", method: .post, parameters: [
            "user_id":LoginUserInfo.getLoginUser().userId
        ]){ code,datas,msg in
        print(datas)
         if(code == 200){
             controller.userInfoDataArr.removeAll()//清空数据源
             for ele in datas{
                 var inexpense = OwnerInputExpenses(
                    month: (ele as!NSDictionary).object(forKey: "month") as! String,
                    totalIncome:(ele as!NSDictionary).object(forKey: "total_income") as! String,
                    totalExpence: (ele as!NSDictionary).object(forKey: "total_expence") as! String,
                    milkTeaIncome: (ele as!NSDictionary).object(forKey: "milk_tea_income") as! String,
                    milkTeaExpence: (ele as!NSDictionary).object(forKey: "milk_tea_expence") as! String,
                    fruitTeaIncome: (ele as!NSDictionary).object(forKey: "fruit_tea_income") as! String,
                    fruitTeaExpence: (ele as!NSDictionary).object(forKey: "fruit_tea_expence") as! String,
                    vegetableTeaIncome: (ele as!NSDictionary).object(forKey: "vegetable_tea_income") as! String,
                    vegetableTeaExpence: (ele as!NSDictionary).object(forKey: "vegetable_tea_expence") as! String,
                    materialExpense: (ele as!NSDictionary).object(forKey: "other_expence") as! String
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
    class func add(){
        
        BaseNetWork.sendDataRequest(url: "http://localhost:8086/inexpense/add", method: .post, parameters: [
            "user_id":LoginUserInfo.getLoginUser().userId
        ]){ code,datas,msg in
        print(datas)
         if(code == 200){
             MsgHelper.showMsg(message:"营销数据计算成功: \(msg)")
             refresh()
         }
         else {
             MsgHelper.showMsg(message:"营销数据计算失败: \(msg)")
         }
    }
    }
}
