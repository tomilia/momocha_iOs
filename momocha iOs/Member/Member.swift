//
//  Member.swift
//  momocha iOs
//
//  Created by Tommy Lee on 17/9/2018.
//  Copyright © 2018 Tommy Lee. All rights reserved.
//

import Foundation
import SwiftyJSON
struct member{
    
    let id: Int?
    let first_name: String?
    let email: String?
    let username: String?
    let phone_num: String?
    init(json: JSON){

        id = json["id"].int ?? -1
        phone_num = json["phone_num"].string ?? ""
        first_name = json["first_name"].string ?? ""
        email = json["email"].string ?? ""
        username = json["username"].string ?? ""
    }
}
