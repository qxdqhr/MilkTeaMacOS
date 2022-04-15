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
                        ownerName: LoginUserInfo.getLoginUser().userName,
                        ownerId: LoginUserInfo.getLoginUser().userId
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
}
