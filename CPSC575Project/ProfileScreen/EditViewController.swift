//
//  EditButtonViewController.swift
//  CPSC575Project
//
//  Created by Selma Novl on 26/11/20.
//  Copyright © 2020 bryan lam. All rights reserved.
//
import SwiftUI

struct EditViewController: View {
    
    @Binding var biography : String
    
    var body: some View {
        NavigationView{
            VStack(alignment:.leading){
                TextField("biography", text: $biography)
            }
        }
    }
    
}
