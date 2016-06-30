//
//  Turno.swift
//  TuTurno
//
//  Created by SP30 on 10/6/16.
//  Copyright © 2016 SP30. All rights reserved.
//

import Foundation
import ObjectMapper

class Turno: Mappable{
    
    var idTurno:Int!
    var dateTurno:String!
    var numberAssigned:Int!
    var numberActual:Int!
    var esperaPromedio:Int!
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.idTurno <- map ["idTurno"]
        self.dateTurno <- map["DateTurno"]
        self.numberAssigned <- map ["NumberAssigned"]
        self.numberActual <- map ["NumberActual"]
        self.esperaPromedio <- map ["EsperaPromedio"]
        
    }

}
