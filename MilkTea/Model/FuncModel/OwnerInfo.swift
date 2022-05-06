//
//  OwnerInfo.swift
//  MilkTea
//
//  Created by tiger on 2022/3/13.
//
//经销商的商户管理界面,这个界面下经销商能看到自己管理的所有商户
import Foundation
class OwnerInfo : BaseModel {
    @objc var ownerId:String = ""            //门店账号
    @objc var alertTimes :String = ""
    @objc var recentAlertReason :String = ""
    @objc var operate :String = ""
    
    init(ownerId:String,alertTimes:String,recentAlertReason:String){
        self.ownerId = ownerId
        self.alertTimes = alertTimes
        self.recentAlertReason = recentAlertReason
    }
    
    subscript( index: String) -> String {
        get {
            switch index{
            case "商户账号": return self.ownerId
            case "已告警次数": return self.alertTimes
            case "最近告警原因": return self.recentAlertReason
            default: return ""
            }
        }
    }
    override class func getUIName()->[String]{
        var uiNames :[String] = []
        for property in propertyList(){
            var uiName :String
            switch property{
            case "ownerId": uiName = "商户账号"
            case "alertTimes": uiName = "已告警次数"
            case "recentAlertReason": uiName = "最近告警原因"
            case "operate": uiName = "操作"
            default:
                uiName = ""
            }
            uiNames.append(uiName)
        }
        return uiNames
    }
}
