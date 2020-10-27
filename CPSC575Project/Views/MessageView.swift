//
//  MessageView.swift
//  CPSC575Project
//
//  Created by bryan lam on 2020-10-18.
//  Copyright © 2020 bryan lam. All rights reserved.
//

import SwiftUI

struct MessageView: View {
    //Hardcoded test values
    let newMatches = testMsgBubble
    
    var body: some View {
        NavigationView{
            ScrollView(.vertical) {
            
                VStack(alignment: .leading){
                    HStack {
                        Spacer()
                    }
                    Text("New Matches")
                        .font(.title)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        NavigationLink(destination: Text("test")){
                            HStack{
                                //For loop here, will display new matches bubbles
                                ForEach(0..<newMatches.count) { index in
                                    Text(self.newMatches[index].name)
                                }
                            }
                        }
                    }
                    Text("Messages")
                        .font(.title)
                    
                    //For loop here
                    ForEach(0..<newMatches.count) { index in
                        NavigationLink(destination: TestView()){
                            Text(self.newMatches[index].name)
                        }
                    }
                    
                    
                    
                    
                    Spacer()
                    
                }
                
            }
        }
        
    }
    
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
    }
}
