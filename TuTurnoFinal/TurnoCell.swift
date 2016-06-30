//
//  TurnoCell.swift
//  TuTurno
//
//  Created by Jose Luis Marrero on 24/6/16.
//  Copyright © 2016 SP30. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON

class TurnoCell: UICollectionViewCell {
    
    var day: Turno! {
        
        didSet {
            //updateUI()
        }
    }
    
    @IBOutlet weak var Comercio: UILabel!
    @IBOutlet weak var TuTurno: UILabel!
    @IBOutlet weak var TurnoAct: UILabel!
    @IBOutlet weak var EsperaProm: UILabel!
    
}
