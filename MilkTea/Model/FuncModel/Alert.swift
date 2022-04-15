//
//  Alert.swift
//  MilkTea
//
//  Created by tiger on 2022/3/7.
//

import Foundation
class Alert : BaseModel {
    @objc var Id  = ""
    @objc var alertReason  = ""
    @objc var alertMethod  = ""
    @objc var alertOwner  = ""
    @objc var alertExOwner  = ""
    @objc var alertTime  = ""
    @objc var alertReceived  = ""


    init(
        Id:String,
        alertReason:String,
         alertMethod:String,
         alertOwner:String,
         alertExOwner:String,
         alertTime:String,
         alertReceived:String
    ){
        self.Id = Id
        self.alertReason = alertReason
        self.alertMethod = alertMethod
        self.alertOwner = alertOwner
        self.alertExOwner = alertExOwner
        self.alertTime = alertTime
        self.alertReceived = alertReceived
    }
    
        

    subscript(index: String) -> String {
        get {
            switch index{
            case "告警时间": return alertTime
            case "告警原因": return alertReason
            case "告警措施": return alertMethod
            case "告警加盟商户": return alertOwner
            case "发送告警经销商": return alertExOwner
            case "是否接受告警": return alertReceived
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
            case "alertTime": uiName = "告警时间"
            case "alertReceived": uiName = "是否接受告警"
            default:
                uiName = ""
            }
            uiNames.append(uiName)
        }
        return uiNames
    }

}
