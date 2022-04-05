//
//  JuiceMaterialNetWork.swift
//  MilkTea
//
//  Created by tiger on 2022/4/3.
//


import Foundation
class MaterialNetwork{
    class func refresh(){
        let materialViewController = (((WindowManager.shared.MainWnd.contentViewController as! MainMenuViewController)
            .contentViewControllerItem.viewController as! ContentSplitViewController)
            .detailViewController.tabViewItems[4].viewController as! JuiceMaterialViewController)
        BaseNetWork.sendDataRequest(url: "http://localhost:8086/material/refresh", method: .post, parameters: [
            "user_id":LoginUserInfo.getLoginUser().userId
        ]){ code,datas,msg in
        print(datas)
         if(code == 200){
             materialViewController.datas.removeAll()//清空数据源
             for ele in datas{
                 let material = JuiceMaterial(
                     juiceMaterialName: (ele as!NSDictionary).object(forKey: "material_name") as! String,
                     materialNumber: (ele as!NSDictionary).object(forKey: "material_number") as! String,
                     materialPerPrice: (ele as!NSDictionary).object(forKey: "per_price") as! String,
                     materialMonthBuyingTime:(ele as!NSDictionary).object(forKey: "material_month_buying_time") as! String,
                     materialMonthTotalPrice:(ele as!NSDictionary).object(forKey: "material_month_total_price") as! String
                 )
                 material.id = (ele as!NSDictionary).object(forKey: "material_id") as! String
                 materialViewController.datas.append(material)//添加新数据
                
             }
             materialViewController.juiceMaterialTable.reloadData()//重载数据
    
             MsgHelper.showMsg(message:"刷新成功: \(msg)")
         }
         else {
             MsgHelper.showMsg(message:"刷新失败: \(msg)")
         }
        }
    }
    class func modify(para:[String:String]){
        print("para:\(para)")
        BaseNetWork.sendDataRequest(url: "http://localhost:8086/material/modify", method: .post, parameters:para ){ code,datas,msg in
            print(datas)
             if(code == 200){
                 MsgHelper.showMsg(message:"修改成功")
                 MaterialNetwork.refresh()
             }
             else {
                 MsgHelper.showMsg(message:"修改失败: \(msg)")
             }
     
        }
    }
    class func add(para:JuiceMaterial){
        print(para)
        BaseNetWork.sendModelDataRequest(url: "http://localhost:8086/material/add", method: .post, parameters: para){ code,data,msg in
            print("para:\(para)")
             if(code == 200){
                 MsgHelper.showMsg(message:"数据添加成功")
                 //确定后自动刷新
                 MaterialNetwork.refresh()
             }
             else {
                 MsgHelper.showMsg(message:"数据添加失败: \(msg)")
             }
        }
    }
    class func query(para:[String:String]){
        let materialViewController = (((WindowManager.shared.MainWnd.contentViewController as! MainMenuViewController)
                                    .contentViewControllerItem.viewController as! ContentSplitViewController)
                                  .detailViewController.tabViewItems[4].viewController as! JuiceMaterialViewController)
        BaseNetWork.sendDataRequest(url: "http://localhost:8086/material/query", method: .post,parameters: para){ code,datas,msg in
            print("para:\(para)")
            if(code == 200){
                MsgHelper.showMsg(message:"查询成功: \(msg)")
                materialViewController.datas.removeAll()//清空数据源
                
                for ele in datas{
                    let material = JuiceMaterial(
                        juiceMaterialName: (ele as!NSDictionary).object(forKey: "material_name") as! String,
                        materialNumber: (ele as!NSDictionary).object(forKey: "material_number") as! String,
                        materialPerPrice: (ele as!NSDictionary).object(forKey: "per_price") as! String,
                        materialMonthBuyingTime:(ele as!NSDictionary).object(forKey: "material_month_buying_time") as! String,
                        materialMonthTotalPrice:(ele as!NSDictionary).object(forKey: "material_month_total_price") as! String
                    )
                    material.id = (ele as!NSDictionary).object(forKey: "material_id") as! String
                    materialViewController.datas.append(material)//添加新数据
                }
                materialViewController.juiceMaterialTable.reloadData()//重载数据
            }
             else {
                 MsgHelper.showMsg(message:"查询失败: \(msg)")
             }
        }
    }
    
    class func delete(para:[String:String]){
        print(para)
        BaseNetWork.sendDataRequest(url: "http://localhost:8086/material/delete", method: .post,parameters: para){ code,datas,msg in
            print("para:\(para)")
            if(code == 200){
                MsgHelper.showMsg(message:"删除成功: \(msg)")
                MaterialNetwork.refresh()
            }
             else {
                 MsgHelper.showMsg(message:"删除失败: \(msg)")
             }
        }
    }
    
}

