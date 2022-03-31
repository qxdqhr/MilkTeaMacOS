//
//  CustomerOrder.swift
//  MilkTea
//
//  Created by tiger on 2022/3/1.
//

import Foundation

class CustomerOrder : BaseModel {
    @objc var orderId:String = ""  //主键
    @objc var userId:String = ""  //分店账号
    @objc var customerName:String = ""          //顾客名称
    @objc var buyingjuice :String = ""          //购买饮品
    @objc var orderingTime :String = ""         //下单时间
    @objc var juiceNumber :String = ""          //本单饮品数量
    @objc var totalSellingPrice :String = ""    //总售价
    @objc var curEvaluate :String = ""          //本单评价
    @objc var operate :String = ""


    init(customerName:String,buyingjuice:String,orderingTime:String,juiceNumber:String,totalSellingPrice:String,curEvaluate:String){
        self.customerName = customerName
        self.buyingjuice = buyingjuice
        self.orderingTime = orderingTime //下单时间
        self.juiceNumber  = juiceNumber  //本单饮品数量
        self.totalSellingPrice = totalSellingPrice //总售价
        self.curEvaluate = curEvaluate
    }
    
    subscript(index: String) -> Any?{
        get {
            switch index{
            case "顾客名": return self.customerName
            case "购买饮品": return self.buyingjuice
            case "下单时间": return self.orderingTime
            case "本单饮品数量": return self.juiceNumber
            case "总售价": return self.totalSellingPrice
            case "本单评价": return self.curEvaluate
            default: return ""
            }
        }
    }
    override func getOrderID() -> String {
        return ("o_\(Date().timeIntervalSince1970)" as NSString).substring(to: 10)
    }
    override class func getUIName()->[String]{
        var uiNames :[String] = []
        for property in propertyList(){
            var uiName :String
            switch property{
            case "orderId": uiName = "主键"
            case "userId": uiName = "分店账号"
            case "customerName": uiName = "顾客名"
            case "buyingjuice": uiName = "购买饮品"
            case "orderingTime": uiName = "下单时间"
            case "juiceNumber": uiName = "本单饮品数量"
            case "totalSellingPrice": uiName = "总售价"
            case "curEvaluate": uiName = "本单评价"
            case "operate": uiName = "操作"
            default:
                uiName = ""
            }
            uiNames.append(uiName)
        }
        return uiNames
    }
    override func toKeyValue() -> [String : String] {
        [
            "orderid":self.orderId,
            "userid":self.userId,
            "customerid":self.customerName,
            "orderingtime":self.orderingTime,
            "buyingjuice":self.buyingjuice,
            "juicenumber":self.juiceNumber,
            "totalsellingprice":self.totalSellingPrice,
            "curevaluate":self.curEvaluate,
        ]
    }

}


