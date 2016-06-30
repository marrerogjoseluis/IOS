//
//  HistoricalTurnosViewController.swift
//  TuTurno
//
//  Created by SP30 on 15/6/16.
//  Copyright © 2016 SP30. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift
import DateTools

class HistoricalTurnosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    static let htvc = HistoricalTurnosViewController()
    
    var allHistoricalTurnosList = try! Realm().objects(HistoricalTurnos)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        HistoricalTurnosViewController.htvc.realm.beginWrite()
//        HistoricalTurnosViewController.htvc.realm.deleteAll()
//        try! HistoricalTurnosViewController.htvc.realm.commitWrite()
        
        HistoricalTurnosViewController.htvc.populateDefaultHistoricalTurnos()
       
        allHistoricalTurnosList = try! Realm().objects(HistoricalTurnos)
//        
//        print (allHistoricalTurnosList.count)
//        print (allHistoricalTurnosList)
//        
        self.tablaHisTur.delegate = self
        self.tablaHisTur.dataSource = self
    }

    
    @IBOutlet var tablaHisTur: UITableView!
   
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allHistoricalTurnosList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        tableView.backgroundColor =  UIColor(red:0.633333, green: 0.801961, blue: 0.409804, alpha: 1)
        
        let lista = tableView.dequeueReusableCellWithIdentifier("cellid", forIndexPath: indexPath) as! TBCell
       
        let mTurno = lista as TBCell
        
        if ( indexPath.row % 2 == 0 ){
            mTurno.backgroundColor = UIColor(red:0.733333, green: 0.901961, blue: 0.309804, alpha: 1)
        }else{
            mTurno.backgroundColor = UIColor(red:0.633333, green: 0.801961, blue: 0.309804, alpha: 1)
        }
        
        
        mTurno.comercioNameLabel.text = "Comercio: "+allHistoricalTurnosList[indexPath.row].comercioName
        mTurno.FechaLabel.text = "Fecha: "+allHistoricalTurnosList[indexPath.row].dateTurno.formattedDateWithFormat("dd/MM/yyyy - HH:MM")
        mTurno.numeroAssignadoLabel.text = "Nro Turno: "+String(allHistoricalTurnosList[indexPath.row].numberAssigned)
        return mTurno
    }
    
    //Guardar valores en Realm Historical Turnos
    let realm = try! Realm()
    lazy var historicalTurnos: Results<HistoricalTurnos> = { self.realm.objects(HistoricalTurnos) }()

    func populateDefaultHistoricalTurnos() {
        
        if historicalTurnos.count == 0 {
            try! realm.write() {
                let defaultHistoricalTurnos = [[0,"11-Jun-2016 14:50","La Vaca", 0, 8], [1,"19-May-2016 12:50","Carper Automoviles", 1, 15], [2,"28-Dec-2015 16:20","Panaderia Pilar", 2, 5] ]
                let formatter = NSDateFormatter()
                formatter.dateFormat = "dd-MM-yyyy HH:mm"
                
                for hturno in defaultHistoricalTurnos {
                    let newHistTurn = HistoricalTurnos()
                    newHistTurn.idTurno = hturno[0] as! Int
                    newHistTurn.dateTurno = formatter.dateFromString(hturno[1] as! String)!
                    newHistTurn.comercioName = hturno[2] as! String
                    newHistTurn.comercioId = hturno[3] as! Int
                    newHistTurn.numberAssigned = hturno[4] as! Int
                    self.realm.add(newHistTurn)
                }
            }            
            historicalTurnos = realm.objects(HistoricalTurnos)
        }
    }
    
    

}