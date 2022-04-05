//
//  BaseModel.swift
//  MilkTea
//
//  Created by tiger on 2022/3/1.
//

import Foundation
class BaseModel : NSObject,Encodable{
    
    class func propertyList() -> [String] {
        var arr :[String] = []
        var count: UInt32 = 0
        //获取类的属性列表,返回属性列表的数组,可选项
        let list = class_copyPropertyList(self, &count)
        print("属性个数:\(count)")
        //遍历数组
        for i in 0..<Int(count) {
            let pty = list?[i]
            let cName = property_getName(pty!)
            let name = String(utf8String: cName)!
            arr.append(name)
        }
        free(list) //释放list
        return arr
    }
    class func getUIName()->[String]{
        return []
    }
    func getOrderID()-> String {
        return ""
    }
    func getMaterialID()-> String {
        return ""
    }
    func toKeyValue()->[String:String]{
        return [:]
    }

}
