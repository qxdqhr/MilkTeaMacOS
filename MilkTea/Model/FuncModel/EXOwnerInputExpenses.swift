//
//  InputExpences.swift
//  MilkTea
//
//  Created by tiger on 2022/3/1.
//

import Foundation
class EXOwnerInputExpenses : BaseModel {
    @objc var month:String = ""                //月份数
    @objc var ownerName:String = ""            //门店名
    @objc var ownerId:String = ""            //加盟商账号
    @objc var totalIncome:String = ""          //总收入
    @objc var totalExpence:String = ""         //总支出
    @objc var operate :String = ""


    init(month:String,
         totalIncome:String,
         totalExpence:String,
         ownerName:String,
         ownerId:String
    ){
        self.month = month
        self.totalIncome = totalIncome
        self.totalExpence = totalExpence
        self.ownerName = ownerName
        self.ownerId = ownerId
    }
    
    subscript(index: String) -> String {
        get {
            switch index{
                case "月份数": return self.month
                case "总收入": return self.totalIncome
                case "总支出": return self.totalExpence
                case "门店名": return self.ownerName
                case "门店账号": return self.ownerId

                default: return ""
            }
        }
    }
    override class func getUIName()->[String]{
        var uiNames :[String] = []
        for property in propertyList(){
            var uiName :String
            switch property{
            case "ownerName": uiName = "门店名"
            case "ownerId": uiName = "门店账号"
            case "month": uiName = "月份数"
            case "totalIncome": uiName = "总收入"
            case "totalExpence": uiName = "总支出"
            case "operate": uiName = "操作"
            default:
                uiName = ""
            }
            uiNames.append(uiName)
        }
        return uiNames
    }

}
