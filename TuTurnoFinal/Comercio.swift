//
//  File.swift
//  TuTurno
//
//  Created by SP30 on 10/6/16.
//  Copyright © 2016 SP30. All rights reserved.
//

import Foundation
import ObjectMapper

class Comercio: Mappable{
    
    var idComercio:Int!
    var nameComercio:String!
    var listaTurnos:[Turno]!
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.idComercio <- map ["IdComercio"]
        self.nameComercio <- map ["NameComercio"]
        self.listaTurnos <- map ["ListaTurnos"]
        
    }
    
}
