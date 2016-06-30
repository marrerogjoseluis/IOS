//
//  ViewController.swift
//  TuTurno
//
//  Created by SP30 on 10/6/16.
//  Copyright © 2016 SP30. All rights reserved.
//

//recargar cada tanto
// mientras tengas turnos activas poner boton para QR
// si no tengo turnos que me aparezca el QR

import UIKit
import Foundation
import SwiftyJSON
import ObjectMapper
import Alamofire
import SwiftLocation
import RealmSwift

class HomeViewController: UIViewController{
    
    @IBOutlet weak var ComercioHome: UILabel!
    @IBOutlet weak var TuTurnoHome: UILabel!
    @IBOutlet weak var TurnoActHome: UILabel!
    @IBOutlet weak var EsperaPromHome: UILabel!
    @IBOutlet weak var EsperaTotal: UILabel!
    @IBOutlet weak var ComerceCollectionView: UICollectionView!
    
    
    var comercio : [Comercio]?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        var time = NSTimer.scheduledTimerWithTimeInterval(8.0, target: self, selector: "update", userInfo: nil, repeats: true)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func update() {
        viewWillAppear(true)
        print("Calling Endpoint")
    }
    
    @IBAction func showQR(sender: AnyObject) {
        self.performSegueWithIdentifier("ShowQR", sender: self)
    }

    let realm = try! Realm()

    override func viewWillAppear(animated: Bool) {
        self.navigationItem .setHidesBackButton(true, animated: false)
        super.viewWillAppear(animated)
        
        APIClient.sharedClient.getTuTurno{ (comercio, error) -> Void in
            
            if var comercio = comercio {
                self.comercio = comercio
                var i = 0
                for com in comercio{
                    
                    if (com.listaTurnos[0].numberAssigned == com.listaTurnos[0].numberActual){
                        print(i)
                        //Guardo turno en Turnos Historicos
                        
                        try! self.realm.write() {
                            let formatter = NSDateFormatter()
                            formatter.dateFormat = "dd-MM-yyyy HH:mm"
                                let newHistTurn = HistoricalTurnos()
                                newHistTurn.idTurno = com.listaTurnos[0].idTurno
                                newHistTurn.dateTurno =  formatter.dateFromString(com.listaTurnos[0].dateTurno)!
                                newHistTurn.comercioName = com.nameComercio
                                newHistTurn.comercioId = com.idComercio
                                newHistTurn.numberAssigned = com.listaTurnos[0].numberAssigned
                                self.realm.add(newHistTurn)
                            }
                        
                        
                        comercio.removeAtIndex(i)
                        self.comercio = comercio
                        i=0
                        
//                        let alert = UIAlertView()
//                        alert.title = "Es TuTurno en:"
//                        let message = com.nameComercio
//                        alert.message = message
//                        alert.addButtonWithTitle("OK")
//                        alert.show()
                    }
                    i += 1
                }

                if self.comercio?.count > 0 {
                
                self.ComercioHome.text = comercio[0].nameComercio
                self.TuTurnoHome.text = String(comercio[0].listaTurnos[0].numberAssigned)
                self.TurnoActHome.text = String(comercio[0].listaTurnos[0].numberActual)
                self.EsperaPromHome.text = (String(comercio[0].listaTurnos[0].esperaPromedio) + " min")
                
                //let cornerRad = CGFloat (20.0)
                    
                //self.TurnoCell2.layer.cornerRadius = cornerRad
                
                let numberAssigned = comercio[0].listaTurnos[0].numberAssigned
                let numberActual = comercio[0].listaTurnos[0].numberActual
                let esperaPromedio = comercio[0].listaTurnos[0].esperaPromedio
                let calc = (numberAssigned - numberActual)*esperaPromedio

                let calcAux = (String(calc) + " min")
                self.EsperaTotal.text = calcAux
                    
                
                self.ComerceCollectionView.dataSource = self
                self.ComerceCollectionView.reloadData()
                
                
                }else{
                    
                    self.performSegueWithIdentifier("ShowQR", sender: nil)
                }
                
                
            }else {
                
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .Alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                
                self.presentViewController(alert, animated: true, completion: nil)
                
            }
        }
   
        
    }
    private struct Storyboard{
        static let CellIdentifier = "CellComerce"
    }

}

extension HomeViewController : UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
        return comercio?.count ?? 0
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
                let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Storyboard.CellIdentifier, forIndexPath: indexPath) as! TurnoCell
                let cornerRad = CGFloat (20.0)
        
                cell.layer.cornerRadius = cornerRad
        
                cell.Comercio.text = self.comercio![indexPath.row].nameComercio
                //print ("Valor IndexPath.row: \(indexPath.row)")
       
                cell.TurnoAct.text = String(self.comercio![indexPath.row].listaTurnos![0].numberActual)
                cell.TuTurno.text = String(self.comercio![indexPath.row].listaTurnos![0].numberAssigned)
                cell.EsperaProm.text = String(self.comercio![indexPath.row].listaTurnos![0].esperaPromedio) 
        
            return cell

    }
}

extension HomeViewController :UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let numberAssigned = comercio![indexPath.row].listaTurnos[0].numberAssigned
        let numberActual = comercio![indexPath.row].listaTurnos[0].numberActual
        let esperaPromedio = comercio![indexPath.row].listaTurnos[0].esperaPromedio
        let strAux = String(esperaPromedio) + " min"
        
        self.EsperaPromHome.text = strAux
        self.TuTurnoHome.text = String(comercio![indexPath.row].listaTurnos[0].numberAssigned)
        self.ComercioHome.text = (comercio![indexPath.row].nameComercio)
        self.TurnoActHome.text = String(comercio![indexPath.row].listaTurnos[0].numberActual)
        
        let calc = (numberAssigned - numberActual)*esperaPromedio
        
        let calcAux = (String(calc) + " min")
        self.EsperaTotal.text = calcAux
    }
    
}

