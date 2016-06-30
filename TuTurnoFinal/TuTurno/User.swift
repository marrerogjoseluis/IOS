//
//  Users.swift
//  TuTurno
//
//  Created by Paula Fassanello on 25/6/16.
//  Copyright © 2016 SP30. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {

    dynamic var nombre:String = ""
    dynamic var email:String = ""
    dynamic var password:String = ""
    
    override static func primaryKey() -> String? {
        return "email"
    }
    
}
