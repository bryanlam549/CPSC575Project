//
//  TestView.swift
//  CPSC575Project
//
//  Created by bryan lam on 2020-10-18.
//  Copyright © 2020 bryan lam. All rights reserved.
//

import SwiftUI


struct TestView: View {
    //hardcoded data
    //let data = testData
    
    //Make use of the view model
    @ObservedObject private var viewModel = VMtest()
    
    //Hardcoded test values
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




struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
