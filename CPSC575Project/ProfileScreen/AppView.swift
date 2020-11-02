//
//  AppView.swift
//  CPSC575Project
//
//  Created by Selma Novl on 2020-10-28.
//  Copyright © 2020 bryan lam. All rights reserved.
//


import Foundation
import SwiftUI

struct AppView: View {
    var body: some View {
        TabView {
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    
                }
            Text("")
                .tabItem {
                    Image(systemName: "heart.fill")
                }
            
            Text("")
                .tabItem {
                    Image(systemName: "message.fill")
                }
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}

