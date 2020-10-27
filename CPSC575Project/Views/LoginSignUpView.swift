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
    
    var body: some View{
        VStack{
            HStack(spacing: 15){
                TextField("Enter Email Address", text: $model.mail)
            }.padding(.vertical, 20)
            
            Divider()
            
            HStack(spacing: 15){
                SecureField("Enter Password", text: $model.pass)
                Button(action:{
                    
                }){
                    Image(systemName: "eye")
                }
            }.padding(.vertical, 20)
            
            Button(action:{
                self.model.login()
            }){
                Text("LOGIN")
            }
            
        }
        .padding(.vertical)
        .padding(.horizontal,20)
        .cornerRadius(10)
    }
    
}

struct SignUpView: View{
    @EnvironmentObject var model: LoginSignUpModel
    
    var body: some View{
        VStack{
            HStack(spacing: 15){
                TextField("Enter Email Address", text: $model.email_SignUp)
            }.padding(.vertical, 20)
            
            Divider()
            
            HStack(spacing: 15){
                SecureField("Enter Password", text: $model.password_SignUp)
                Button(action:{
                    
                }){
                    Image(systemName: "eye")
                }
            }.padding(.vertical, 20)
            
            Divider()
            
            HStack(spacing: 15){
                SecureField("Re-Enter Pass", text: $model.reEnterPassword)
                Button(action:{
                    
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
    }
    
    
    
}
