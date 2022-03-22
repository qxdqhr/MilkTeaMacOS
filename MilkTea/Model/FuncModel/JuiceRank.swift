//
//  JuiceOrder.swift
//  MilkTea
//
//  Created by tiger on 2022/3/1.
//

import Foundation
class JuiceRank : BaseModel {
    @objc var juiceName:String = ""              //饮品名称
    @objc var juiceSoldNumber :String = ""       //饮品历史销售数量
    @objc var sellingTotalPrice :String = ""     //总销售额
    @objc var goodEvaluateNum :String = ""       //好评数

    init(juiceName:String,
         juiceSoldNumber:String,
         sellingTotalPrice:String,
         goodEvaluateNum:String){
        self.juiceName = juiceName
        self.juiceSoldNumber = juiceSoldNumber
        self.sellingTotalPrice  = sellingTotalPrice
        self.goodEvaluateNum = goodEvaluateNum
    }
    
    subscript(index: String) -> String {
        get {
            switch index{
            case "饮品名称": return self.juiceName
            case "饮品历史销售数量": return juiceSoldNumber
            case "总销售额": return self.sellingTotalPrice
            case "好评数": return self.goodEvaluateNum
            default: return ""
            }
        }
    }
    override class func getUIName()->[String]{
        var uiNames :[String] = []
        for property in propertyList(){
            var uiName :String
            switch property{
            case "juiceName": uiName = "饮品名称"
            case "juiceSoldNumber": uiName = "饮品历史销售数量"
            case "sellingTotalPrice": uiName = "总销售额"
            case "goodEvaluateNum": uiName = "好评数"
            default:
                uiName = ""
            }
            uiNames.append(uiName)
        }
        return uiNames
    }

}
