//
//  InputExpences.swift
//  MilkTea
//
//  Created by tiger on 2022/3/1.
//

import Foundation
class OwnerInputExpenses : BaseModel {
    @objc var month:String = ""                 //月份数
    @objc var totalIncome:String = ""          //总收入
    @objc var totalExpence:String = ""         //总支出
    
    @objc var milkTeaIncome:String = ""        //奶茶收入
    @objc var milkTeaExpence:String = ""       //奶茶支出
    
    @objc var fruitTeaIncome:String = ""       //果茶收入
    @objc var fruitTeaExpence:String = ""      //果茶支出
    
    @objc var vegetableTeaIncome:String = ""          //青汁收入
    @objc var vegetableTeaExpence:String = ""          //青汁支出
    @objc var materialExpense:String = ""          //原料支出



    init(month:String,
         totalIncome:String,
         totalExpence:String,
         milkTeaIncome:String,
         milkTeaExpence:String,
         fruitTeaIncome:String,
         fruitTeaExpence:String,
         vegetableTeaIncome:String,
         vegetableTeaExpence:String,
         materialExpense:String
    ){
        self.month = month
        self.totalIncome = totalIncome
        self.totalExpence = totalExpence
        self.milkTeaIncome = milkTeaIncome
        self.milkTeaExpence = milkTeaExpence
        self.fruitTeaIncome = fruitTeaIncome
        self.fruitTeaExpence = fruitTeaExpence
        self.vegetableTeaIncome = vegetableTeaIncome
        self.vegetableTeaExpence = vegetableTeaExpence
        self.materialExpense = materialExpense
    }
    
        

    subscript(index: String) -> String {
        get {
            switch index{
                case "月份数": return self.month
                case "总收入": return self.totalIncome
                case "总支出": return self.totalExpence
                case "奶茶收入": return self.milkTeaIncome
                case "奶茶支出": return self.milkTeaExpence
                case "果茶收入": return self.fruitTeaIncome
                case "果茶支出": return self.fruitTeaExpence
                case "青汁收入": return self.vegetableTeaIncome
                case "青汁支出": return self.vegetableTeaExpence
                case "原料支出": return self.materialExpense
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
            case "month": uiName = "月份数"
            case "totalIncome": uiName = "总收入"
            case "totalExpence": uiName = "总支出"
            case "milkTeaIncome": uiName = "奶茶收入"
            case "milkTeaExpence": uiName = "奶茶支出"
            case "fruitTeaIncome": uiName = "果茶收入"
            case "fruitTeaExpence": uiName = "果茶支出"
            case "vegetableTeaIncome": uiName = "青汁收入"
            case "vegetableTeaExpence": uiName = "青汁支出"
            case "materialExpense": uiName = "原料支出"
            default:
                uiName = ""
            }
            uiNames.append(uiName)
        }
        return uiNames
    }

}
