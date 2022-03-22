//
//  JuiceMaterial.swift
//  MilkTea
//
//  Created by tiger on 2022/3/1.
//

import Foundation
class JuiceMaterial : BaseModel {
    @objc var juiceMaterialName:String = ""      //原料名称
    @objc var materialNumber :String = ""        //本次购入原料数量
    @objc var materialPerPrice :String = ""      //原料单价
    @objc var materialMonthBuyingTime :String = ""          //购入时间
    @objc var materialMonthTotalPrice :String = ""    //购入总成本
    @objc var operate :String = ""

    init(juiceMaterialName:String,
         materialNumber:String,
         materialPerPrice:String,
         materialMonthBuyingTime:String,
         materialMonthTotalPrice:String
    ){
        self.juiceMaterialName = juiceMaterialName
        self.materialNumber = materialNumber
        self.materialPerPrice = materialPerPrice
        self.materialMonthBuyingTime = materialMonthBuyingTime
        self.materialMonthTotalPrice = materialMonthTotalPrice
    }
    
    subscript(index: String) -> String {
        get {
            switch index{
            case "原料名称": return self.juiceMaterialName
            case "购入数量": return self.materialNumber
            case "原料单价": return self.materialPerPrice
            case "购入时间": return self.materialMonthBuyingTime
            case "购入成本": return self.materialMonthTotalPrice
            default: return ""
            }
        }
    }
    override class func getUIName()->[String]{
        var uiNames :[String] = []
        for property in propertyList(){
            var uiName :String
            switch property{
            case "juiceMaterialName": uiName = "原料名称"
            case "materialNumber": uiName = "购入数量"
            case "materialPerPrice": uiName = "原料单价"
            case "materialMonthBuyingTime": uiName = "购入时间"
            case "materialMonthTotalPrice": uiName = "购入成本"
            case "operate": uiName = "操作"
            default:
                uiName = ""
            }
            uiNames.append(uiName)
        }
        return uiNames
    }

}
