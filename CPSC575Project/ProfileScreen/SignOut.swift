//
//  SignOut.swift
//  CPSC575Project
//
//  Created by bryan lam on 2020-10-18.
//  Copyright © 2020 bryan lam. All rights reserved.
//

import SwiftUI


struct SignOut: View {
    @EnvironmentObject var model: LoginSignUpModel
    @Binding var backButtonPressed: Bool
    var body: some View {
        Group{
            Button(action: {
                self.backButtonPressed.toggle()
            }) {
                Text("Back button")
            }
            
            Divider()
            Spacer()

                
            Text("Temporary signout screen (settings not functional...)")
            Button(action:{
                //THIS IS A TEST...But this is how you'd sign out
                self.model.logOut()
            }){
                Text("Sign out")
            }
            
        }
        
    }
}

