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
    @Published var logInstatus = (FirebaseAuth.Auth.auth().currentUser != nil)
    
    func login(){
        
        // checking all fields are inputted correctly...
        if mail == "" || pass == ""{
            
            self.alertMsg = "Fill the contents properly !!!"
            self.alert.toggle()
            return
        }
        
        FirebaseAuth.Auth.auth().signIn(withEmail: mail, password: pass, completion: { result, error in
            guard error == nil else{
                //Let user that credential is wrong
                self.alertMsg = error!.localizedDescription
                self.alert.toggle()
                return
            }
            
            // checking if user is verifed or not...
            // if not verified means lgging out...
            
            let user = Auth.auth().currentUser
            
            if user == nil{
                return
            }
            
            if !user!.isEmailVerified{
                self.alertMsg = "Please Verify Email Address!!!"
                self.alert.toggle()
                // logging out...
                try! Auth.auth().signOut()
                
                return
            }
            
            withAnimation{
                self.logInstatus = true
            }
            
        })
        
        
    
    }
    func signUp(){
        // checking....
        if email_SignUp == "" || password_SignUp == "" || reEnterPassword == ""{
            
            self.alertMsg = "Fill contents proprely!!!"
            self.alert.toggle()
            return
        }
        
        if password_SignUp != reEnterPassword{
            
            self.alertMsg = "Password Mismatch !!!"
            self.alert.toggle()
            return
        }
        
        
        //Create user
        FirebaseAuth.Auth.auth().createUser(withEmail: email_SignUp, password: password_SignUp, completion: { result, error in
            guard error == nil else{
                //Let user that credential is wrong
                self.alertMsg = error!.localizedDescription
                self.alert.toggle()
                return
            }
            
            // sending Verifcation Link....
            
            result?.user.sendEmailVerification(completion: { (err) in
                
                if err != nil{
                    self.alertMsg = err!.localizedDescription
                    self.alert.toggle()
                    return
                }
                
                // Alerting User To Verify Email...
                
                self.alertMsg = "Email Verification Has Been Sent !!! Verify Your Email ID !!!"
                self.alert.toggle()
            })

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
    func resetPassword(){
        
        let alert = UIAlertController(title: "Reset Password", message: "Enter Your E-Mail ID To Reset Your Password", preferredStyle: .alert)
        
        alert.addTextField { (password) in
            password.placeholder = "Email"
        }
        
        let proceed = UIAlertAction(title: "Reset", style: .default) { (_) in
            
            // Sending Password Link...
            
            if alert.textFields![0].text! != ""{
                
                Auth.auth().sendPasswordReset(withEmail: alert.textFields![0].text!) { (err) in
                    
                    if err != nil{
                        self.alertMsg = err!.localizedDescription
                        self.alert.toggle()
                        return
                    }
                    
                    // ALerting User...
                    self.alertMsg = "Password Reset Link Has Been Sent !!!"
                    self.alert.toggle()
                }
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alert.addAction(cancel)
        alert.addAction(proceed)
        
        // Presenting...
        
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
    }
    
}
