//
//  UserLogic.swift
//  TuTurno
//
//  Created by Paula Fassanello on 25/6/16.
//  Copyright © 2016 SP30. All rights reserved.
//

import UIKit
import RealmSwift

class UserLogic {
    
    let realm = try! Realm()
    var newUser = User()
    lazy var users: Results<User> = { self.realm.objects(User) }()
    
    
    func isValidEmail(email:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(email)
    }
    
    func LogInWithUser(email:String, password:String) -> Bool {
        //Realm().objectForPrimaryKey(Book.self, key: prevBook.nextID)
        let myUser = try! Realm().objectForPrimaryKey(User.self, key: email)
        if(myUser?.password == password){
            return true
        }
        return false
    }
   
    func saveUser(name:String, email:String, password:String) -> Bool {
        let myUser = try! Realm().objectForPrimaryKey(User.self, key: email)
        if (myUser == nil){
            try! realm.write() {
                newUser.nombre = name
                newUser.email = email
                newUser.password = password
                self.realm.add(newUser)
                users = try! Realm().objects(User)
            }
            return true
        }
        return false
    }
    
    func changePassword(email:String, password:String, newPassword:String) -> Bool {
        let myUser = try! Realm().objectForPrimaryKey(User.self, key: email)
        if (myUser != nil){
            if( myUser!.password == password){
                try! realm.write() {
                    myUser!.password = newPassword
                }
                return true
            }
        }
        return false
    }
    
}


