//
//  RegisterModel.swift
//  MilkTea
//
//  Created by tiger on 2022/3/3.
//

import Foundation
class UserModel: BaseModel {
    var name :String = ""
    var userid:String = ""
    var telephone:String = ""
    var Password:String = ""
    var role:String = ""
    init(name:String,userid:String,telephone:String,Password:String,role:String){
        self.name = name
        self.userid = userid
        self.telephone = telephone
        self.Password = Password
        self.role = role
    }
    override func toKeyValue() -> [String : String] {
        [
            "name":self.name,
            "userid":self.userid,
            "telephone":self.telephone,
            "password":self.Password,
            "role":self.role
        ]
    }
}
