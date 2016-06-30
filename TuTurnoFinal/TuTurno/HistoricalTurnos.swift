//
//  HistoricalTurnos.swift
//  TuTurno
//
//  Created by SP30 on 15/6/16.
//  Copyright © 2016 SP30. All rights reserved.
//
// https://www.raywenderlich.com/112544/realm-tutorial-getting-started

import Foundation
import RealmSwift

class HistoricalTurnos: Object {

    dynamic var idTurno:Int = 0
    dynamic var dateTurno = NSDate()
    dynamic var comercioName:String = ""
    dynamic var comercioId:Int = 0
    dynamic var numberAssigned:Int=0 
}



