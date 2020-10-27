//
//  ProfileView.swift
//  CPSC575Project
//
//  Created by bryan lam on 2020-10-18.
//  Copyright © 2020 bryan lam. All rights reserved.
//

import SwiftUI
import Firebase

struct ProfileView: View {
    @EnvironmentObject var model: LoginSignUpModel // for testing
    
    var body: some View {
        VStack{
            Text("Profile View")
            //Log out button TESTING
            Button(action:{
                //THIS IS A TEST...But this is how you'd sign out
                self.model.logOut()
            }){
                Text("Sign out")
            }
        }
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
