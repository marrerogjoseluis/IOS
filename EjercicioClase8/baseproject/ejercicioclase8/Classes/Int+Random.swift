//
//  Int+Random.swift
//  EjercicioClase8
//
//  Created by Diego Pais on 4/1/16.
//
//

import Foundation

extension Int {
    
    /**
     Returns a random number between from and to
     */
    public static func randomFrom(from: Int, to: Int) -> Int {
        
        return from + Int(arc4random_uniform(UInt32(to) - UInt32(from) + 1))
    }
}