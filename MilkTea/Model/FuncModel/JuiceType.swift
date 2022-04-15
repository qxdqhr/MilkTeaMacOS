//
//  JuiceType.swift
//  MilkTea
//
//  Created by tiger on 2022/3/1.
//

import Foundation
class JuiceType : BaseModel {
    @objc var juiceId:String = ""  //主键
    @objc var userid:String = ""  //图片数据
    @objc var juiceName:String = ""          //饮品名称
    @objc var juiceType:String = ""          //饮品类型 奶茶/果茶/青汁
    @objc var lastOrderingTime :String = ""  //最近下单时间
    @objc var price  :String = ""      //售价
    @objc var profit :String = ""      //利润
    @objc var cost   :String = ""      //成本
    @objc var curEvaluate :String = ""       //最近评价
    
//-----
    @objc var juiceSoldNumber :String = ""       //饮品历史销售数量
    @objc var sellingTotalPrice :String = ""     //总销售额
    @objc var goodEvaluateNum :String = ""       //好评数

    init(juiceName:String,
         juiceType:String,
         lastOrderingTime:String,
         price  :String,
         profit :String,
         cost   :String,
         curEvaluate:String,
         
         juiceSoldNumber:String,
         sellingTotalPrice:String,
         goodEvaluateNum:String
    ){
        self.juiceName = juiceName
        self.juiceType = juiceType
        self.lastOrderingTime  = lastOrderingTime
        self.price = price
        self.profit = profit
        self.cost = cost
        self.curEvaluate = curEvaluate

        self.juiceSoldNumber = juiceSoldNumber
        self.sellingTotalPrice  = sellingTotalPrice
        self.goodEvaluateNum = goodEvaluateNum
    }
    
    subscript(index: String) -> String {
        get {
            switch index{
            case "饮品名称": return self.juiceName
            case "饮品类型": return self.juiceType
            case "最近下单时间": return self.lastOrderingTime
            case "售价": return self.price
            case "利润": return self.profit
            case "成本": return self.cost
            case "最近评价": return self.curEvaluate
            default: return ""
            }
        }
    }
    override  class func getUIName()->[String]{
        var uiNames :[String] = []
        for property in propertyList(){
            var uiName :String
            switch property{
            case "juiceName": uiName = "饮品名称"
            case "juiceType": uiName = "饮品类型"
            case "lastOrderingTime": uiName = "最近下单时间"
            case "price": uiName = "售价"
            case "profit": uiName = "利润"
            case "cost": uiName = "成本"
            case "curEvaluate": uiName = "最近评价"
            default:
                uiName = ""
            }
            uiNames.append(uiName)
        }
        return uiNames
    }

}
