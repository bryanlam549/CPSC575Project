//
//  ContentView.swift
//  CPSC575Project
//
//  Created by bryan lam on 2020-09-29.
//  Copyright © 2020 bryan lam. All rights reserved.
//
//

import SwiftUI

struct ContentView: View {
    //hardcoded data
    //let data = testData
    
    @ObservedObject private var viewModel = VMtest()
    
    var newCollection = TestCollection(col1: "test", col2: "test", column3: 9)
    
    
    var body: some View {
        VStack {
            Text("TEST LIST")
            List(viewModel.testCollections){ testCol in
                Text(testCol.col1)
            }
            .onAppear(){
                self.viewModel.fetchData()
            }
            
            Button(action: {self.viewModel.addData(collection: self.newCollection)}) {
                
                Text("Add hardcoded values...")
                
            }

        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
