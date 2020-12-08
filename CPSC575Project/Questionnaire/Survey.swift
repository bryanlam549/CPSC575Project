//
//   Survey.swift
//  CPSC575Project
//
//  Created by Selma Novl on 02/12/20.
//  Copyright © 2020 bryan lam. All rights reserved.
//

import SwiftUI

struct _Survey: View {
    
    @Environment(\.presentationMode) var presentationMode:Binding<PresentationMode>
//    put the Answer here, i suggest to leave the first blank
    var Answer1 = ["","answer1","answer2","answer3",]
    var Answer2 = ["","answer1","answer2","answer3",]
    var Answer3 = ["","answer1","answer2","answer3",]
    var Answer4 = ["","answer1","answer2","answer3",]
//     index that recognize the answers inside the picker
    @State private var Index = 0
    @State private var Index1 = 0
    @State private var Index2 = 0
    @State private var Index3 = 0
    
    var body: some View {
        NavigationView{
        Form {
//            put the question inside each picker text labl
            Picker(selection: $Index, label: Text("first question")) {
                    ForEach(0 ..< Answer1.count) {
                        Text(self.Answer1[$0]).tag($0)
                    }
            }
            Spacer()
            Picker(selection: $Index1, label: Text("second question")) {
                ForEach(0 ..< Answer2.count) {
                    Text(self.Answer2[$0]).tag($0)
                }
            }
            Spacer()
            Picker(selection: $Index2, label: Text("third question")) {
                ForEach(0 ..< Answer3.count) {
                    Text(self.Answer3[$0]).tag($0)
                }
            }
            Spacer()
            Picker(selection: $Index3, label: Text("fouth question")) {
                ForEach(0 ..< Answer4.count) {
                    Text(self.Answer4[$0]).tag($0)
                }
                
            }
            Button(action: {
//                put your dismiss here
            }) {
                Text("Done")
                    
                }
            
    }.navigationBarTitle(Text("Questionnaire"))
            
  }
}
    
}


struct _Survey_Previews: PreviewProvider {
    static var previews: some View {
        _Survey()
    }
}
