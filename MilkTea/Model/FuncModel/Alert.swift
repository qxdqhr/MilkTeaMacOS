//
//  Alert.swift
//  MilkTea
//
//  Created by tiger on 2022/3/7.
//

import Foundation
class Alert : BaseModel {
    @objc var alertReason  = ""
    @objc var alertMethod  = ""
    @objc var alertOwner  = ""
    @objc var alertExOwner  = ""


    init(alertReason:String,
         alertMethod:String,
         alertOwner:String,
         alertExOwner:String
    ){
        self.alertReason = alertReason
        self.alertMethod = alertMethod
        self.alertOwner = alertOwner
        self.alertExOwner = alertExOwner
    }
    
        

    subscript(index: String) -> String {
        get {
            switch index{
            case "告警原因": return alertReason
            case "告警措施": return alertMethod
            case "告警加盟商户": return alertOwner
            case "发送告警经销商": return alertExOwner
                default: return ""
            }
        }
    }
    override class func getUIName() -> [String] {
        var uiNames :[String] = []
        for property in propertyList(){
            var uiName :String
            switch property{
            case "alertReason": uiName = "告警原因"
            case "alertMethod": uiName = "告警措施"
            case "alertOwner": uiName = "告警加盟商户"
            case "alertExOwner": uiName = "发送告警经销商"
            default:
                uiName = ""
            }
            uiNames.append(uiName)
        }
        return uiNames
    }

}
