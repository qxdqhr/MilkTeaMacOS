//
//  loginRequest.swift
//  MilkTea
//
//  Created by tiger on 2022/3/2.
//

import Foundation
import Alamofire

class BaseNetWork{
    
    class func sendModelDataRequest(url:String,method:HTTPMethod,parameters:BaseModel, completionHandler: @escaping (_ code:Int, _ data:NSDictionary, _ msg:String) -> Void) {
        AF.request(url,
                   method: method,
                   parameters: parameters.toKeyValue(),
                   encoder: JSONParameterEncoder.default).responseJSON {  response in
            print(parameters)
            switch response.result {
            case .success(let json):             //把得到的JSON数据转为数组
                let dic = json as! NSDictionary
                let code = dic.object(forKey: "code") as? Int  ?? 0
                let data = dic.object(forKey: "data") as? NSDictionary ?? [:]
                let msg = dic.object(forKey: "msg") as? String  ?? ""
                //闭包向外传值
                completionHandler(code, data, msg)
            case .failure(let error):
                print(error)
            }
            
        }
    }
    class func sendDataRequest(url:String,method:HTTPMethod,parameters:[String:String], completionHandler: @escaping (_ code:Int, _ data:[Any], _ msg:String) -> Void) {
        AF.request(url,
                   method: method,
                   parameters: parameters,
                   encoder: JSONParameterEncoder.default).responseJSON {  response in
            print(parameters)
            switch response.result {
            case .success(let json):             //把得到的JSON数据转为数组
                let dic = json as! NSDictionary
                let code = dic.object(forKey: "code") as? Int  ?? 0
                let data = dic.object(forKey: "data") as? [Any] ?? []
                let msg = dic.object(forKey: "msg") as? String  ?? ""
                //闭包向外传值
                completionHandler(code, data, msg)
            case .failure(let error):
                print(error)
            }
            
        }
    }

    

    
    
}





