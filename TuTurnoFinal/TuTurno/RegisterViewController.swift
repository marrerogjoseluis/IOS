//
//  RegisterViewController.swift
//  TuTurno
//
//  Created by SP30 on 24/6/16.
//  Copyright © 2016 SP30. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    let userLogic = UserLogic()
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var nombreText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var repeatPassText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func registrarUser(sender: AnyObject) {
        if(emailText.text == "" || nombreText.text == "" || passwordText.text == "" || repeatPassText.text == ""){
            //Error complete campos
            let alert = UIAlertController(title: "Error", message: "Complete todos los campos", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }else{
            if(userLogic.isValidEmail(emailText.text!) == false){
                //Mail invalido
                let alert = UIAlertController(title: "Error", message: "Email incorrecto", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }else{
                if(passwordText.text != repeatPassText.text){
                    //Password no cohincide
                    let alert = UIAlertController(title: "Error", message: "Nuevos Passwords no coinciden", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }else{
                    if(userLogic.saveUser(nombreText.text!, email: emailText.text!, password: passwordText.text!) == false){
                        //Falla en la creacion de user, usuario Existente
                        let alert = UIAlertController(title: "Error", message: "Usuario ya existente", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                    }else{
                        //Usuario creado exitosamente
                        let alert = UIAlertController(title: "Successful", message: "Usuario agregado satisfactoriamente", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)

                    }
                }
            }
            
        }
    }
    

}
