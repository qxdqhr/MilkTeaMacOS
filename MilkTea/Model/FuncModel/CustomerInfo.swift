//
//  File.swift
//  MilkTea
//
//  Created by tiger on 2022/2/23.
//

import Foundation
class CustomerInfo : BaseModel {
    @objc var customerName:String = ""
    @objc var buyingTime :String = ""
    @objc var recentEvaluate :String = ""
    @objc var operate :String = ""
    
    init(customerName:String,buyingTime:String,recentEvaluate:String){
        self.customerName = customerName
        self.buyingTime = buyingTime
        self.recentEvaluate = recentEvaluate
    }
    
    subscript( index: String) -> String {
        get {
            switch index{
            case "顾客名": return self.customerName
            case "最近购买时间": return self.buyingTime
            case "用户最近评价": return self.recentEvaluate
            default: return ""
            }
        }
    }
    override class func getUIName()->[String]{
        var uiNames :[String] = []
        for property in CustomerInfo.propertyList(){
            var uiName :String
            switch property{
            case "customerName": uiName = "顾客名"
            case "buyingTime": uiName = "最近购买时间"
            case "recentEvaluate": uiName = "用户最近评价"
            case "operate": uiName = "操作"
            default:
                uiName = ""
            }
            uiNames.append(uiName)
        }
        return uiNames
    }

}


