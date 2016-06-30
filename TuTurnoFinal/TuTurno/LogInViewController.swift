//
//  LogInViewController.swift
//  TuTurno
//
//  Created by SP30 on 21/6/16.
//  Copyright © 2016 SP30. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

//https://www.youtube.com/watch?v=cpANieebE2M

class LogInViewController: UIViewController, FBSDKLoginButtonDelegate {

    @IBOutlet weak var logInFacebookButton: FBSDKLoginButton!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    let userLogicVar = UserLogic()

    @IBAction func logInWithRegisteredUser(sender: AnyObject) {
        if(emailText.text == "" || passwordText.text == ""){
            //Usuario o Password Invalido
            let alert = UIAlertController(title: "Error", message: "Complete todos los campos", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }else{
            let logInSuccessfull = userLogicVar.LogInWithUser(emailText.text!, password: passwordText.text!)
            if(logInSuccessfull){
                self.performSegueWithIdentifier("ShowHomePage", sender: self)
            }else{
                //Usuario o Password Incorrecto
                let alert = UIAlertController(title: "Error", message: "Usuario o Password incorrecto", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        if(FBSDKAccessToken.currentAccessToken() == nil){
            print("Not Logged in..")
        }else{
            print("Logged in..")
        }
    
        logInFacebookButton.readPermissions = ["public_profile", "email"]
        logInFacebookButton.delegate = self
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Facebook Login
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        if error == nil{
            print("LogIn complete")
            self.performSegueWithIdentifier("ShowHomePage", sender: self)
        }
        else{
            print(error.localizedDescription)
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print ("User logged out...")
    }
    
    
    @IBAction func goToRegisterVC(sender: AnyObject) {
    }
    
    

    
    

    
}
