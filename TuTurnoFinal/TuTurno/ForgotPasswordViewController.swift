//
//  ForgotPasswordViewController.swift
//  TuTurno
//
//  Created by SP30 on 24/6/16.
//  Copyright © 2016 SP30. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet var emailText: UITextField!
    @IBOutlet var oldPasswordText: UITextField!
    @IBOutlet var newPasswordText: UITextField!
    @IBOutlet var repeatNewPasswordText: UITextField!
    
    let userLogic = UserLogic()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveNewPassword(sender: AnyObject) {
        if(emailText.text == "" || oldPasswordText.text == "" || newPasswordText.text == "" || repeatNewPasswordText.text == "" ){
            //Debe completar todos los campos
            let alert = UIAlertController(title: "Error", message: "Complete todos los campos", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }else{
            if newPasswordText.text != repeatNewPasswordText.text {
                //New Passwords do not match
                let alert = UIAlertController(title: "Error", message: "Nuevos Passwords no coinciden", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }else{
                if(userLogic.changePassword(emailText.text!, password: oldPasswordText.text!, newPassword: newPasswordText.text!) == true){
                    let alert = UIAlertController(title: "Successful", message: "Password cambiado exitosamente", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                    
                }else{
                    let alert = UIAlertController(title: "Error", message: "Usuario inexistente o Password incorrecto", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            }
        }
    }
   
    @IBAction func cancelAndComeBackToLogInViewController(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion:nil )
    }
    
}
