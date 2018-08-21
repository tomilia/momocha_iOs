//
//  Place.swift
//  momocha iOs
//
//  Created by Tommy Lee on 18/8/2018.
//  Copyright © 2018 Tommy Lee. All rights reserved.
//

import Foundation

struct FilterType {
    var type: String!
    var name: [String]!
    var expanded: Bool!
    
    init(type: String, name: [String], expanded: Bool){
        self.type = type
        self.name = name
        self.expanded = expanded
    }
}
