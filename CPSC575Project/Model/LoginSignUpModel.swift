//
//  LoginSignUpModel.swift
//  CPSC575Project
//
//  Created by bryan lam on 2020-10-27.
//  Copyright © 2020 bryan lam. All rights reserved.
//

import SwiftUI
import Foundation
import Firebase


class LoginSignUpModel : ObservableObject{
    @Published var mail = ""
    @Published var pass = ""
    @Published var isSignUp = false
    @Published var email_SignUp = ""
    @Published var password_SignUp = ""
    @Published var reEnterPassword = ""
    
    // Error Alerts...To be added
    @Published var alert = false
    @Published var alertMsg = ""
    
    // User Status....
    @Published var logInstatus = false
    
    func login(){

        FirebaseAuth.Auth.auth().signIn(withEmail: mail, password: pass, completion: { result, error in
            guard error == nil else{
                //TODO: Let user that credential is wrong
                print("TEST MSG: account doesn't exists")
                return
            }
            
            print("TEST MSG: you have signed in")
            withAnimation{
                self.logInstatus = true
            }
            
        })
    
    }
    func signUp(){
        //Create user
        FirebaseAuth.Auth.auth().createUser(withEmail: email_SignUp, password: password_SignUp, completion: { result, error in
            guard error == nil else{
                //TODO: Let user that credential is wrong
                print("TEST MSG: fill in all fields")
                return
            }
            
            self.isSignUp = false
            self.mail = ""
            self.pass = ""
            self.email_SignUp = ""
            self.password_SignUp = ""
            self.reEnterPassword = ""
            print("TST MSG: account has been created")
        })
    }
    func logOut(){
        
        try! Auth.auth().signOut()
        
        withAnimation{
            self.logInstatus = false
        }
        
        // clearing all data...
        
        mail = ""
        pass = ""
        email_SignUp = ""
        password_SignUp = ""
        reEnterPassword = ""
    }
    
}
