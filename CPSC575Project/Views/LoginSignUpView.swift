//
//  LoginView.swift
//  CPSC575Project
//
//  Created by bryan lam on 2020-10-25.
//  Copyright © 2020 bryan lam. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI
import Firebase

struct LoginView: View{
    @EnvironmentObject var model: LoginSignUpModel
    @State var hidepass = true
    var body: some View{
        VStack{
            HStack(spacing: 15){
                TextField("Enter Email Address", text: $model.mail)
            }.padding(.vertical, 20)
            
            Divider()
            
            HStack(spacing: 15){
                if (hidepass){
                    SecureField("Enter Password", text: $model.pass)
                }else{
                    TextField(model.pass, text: $model.pass)
                }
                Button(action:{
                    self.hidepass.toggle()
                }){
                    Image(systemName: "eye")
                }
            }.padding(.vertical, 20)
            
            Button(action:{
                self.model.login()
            }){
                Text("LOGIN")
            }
            
            Divider()
            
            HStack{
                Button(action: {
                    
                }) {
                    Image("fb")
                        .renderingMode(.original)
                        .padding()
                    
                }.background(Color.white)
                .clipShape(Circle())
                
                Button(action: {
                    
                }) {
                    Image("google")
                        .renderingMode(.original)
                        .padding()
                    
                }.background(Color.white)
                .clipShape(Circle())
            }
            
            Button(action:{
                self.model.resetPassword()
            }){
                Text("Forget Password?")
                .fontWeight(.bold)
            }
            
            
            
        }
        .padding(.vertical)
        .padding(.horizontal,20)
        .cornerRadius(10)
        // Alerts...
        .alert(isPresented: $model.alert, content: {
            Alert(title: Text("Message"), message: Text(model.alertMsg), dismissButton: .destructive(Text("Ok")))
        })
    }
    
}

struct SignUpView: View{
    @EnvironmentObject var model: LoginSignUpModel
    @State var hidepass1 = true
    @State var hidepass2 = true
    var body: some View{
        VStack{
            HStack(spacing: 15){
                TextField("Enter Email Address", text: $model.email_SignUp)
            }.padding(.vertical, 20)
            
            Divider()
            
            HStack(spacing: 15){
                if(hidepass1){
                    SecureField("Enter Password", text: $model.password_SignUp)
                }else{
                    TextField(self.model.password_SignUp, text: $model.password_SignUp)
                }
                Button(action:{
                    self.hidepass1.toggle()
                }){
                    Image(systemName: "eye")
                }
            }.padding(.vertical, 20)
            
            Divider()
            
            HStack(spacing: 15){
                if(hidepass2){
                    SecureField("Re-Enter Pass", text: $model.reEnterPassword)
                }else{
                    TextField(self.model.reEnterPassword, text: $model.reEnterPassword)
                }
                Button(action:{
                    self.hidepass2.toggle()
                }){
                    Image(systemName: "eye")
                }
            }.padding(.vertical, 20)
            
            Button(action:{
                self.model.signUp()
            }){
                Text("SIGN UP")
            }
        }
        .padding(.vertical)
        .padding(.horizontal,20)
        .cornerRadius(10)
        // Alerts...
        .alert(isPresented: $model.alert, content: {
            
            Alert(title: Text("Message"), message: Text(model.alertMsg), dismissButton: .destructive(Text("Ok"), action: {
                 
                // if email link sent means closing the signupView....
                
                if self.model.alertMsg == "Email Verification Has Been Sent !!! Verify Your Email ID !!!"{
                    
                    self.model.isSignUp.toggle()
                    self.model.email_SignUp = ""
                    self.model.password_SignUp = ""
                    self.model.reEnterPassword = ""
                }
                
            }))
        })
    }
    
    
    
}
