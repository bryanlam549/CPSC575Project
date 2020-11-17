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
            let testMsgCells = testMessagesCells
            
            var body: some View {
                NavigationView{
                    VStack{
                    TopView()
                    ListTitleView(title: "New Matches")
                    ScrollView(.horizontal, showsIndicators: false) {
                        // NavigationLink(destination: Text("test")){
                        HStack{
                            
                            NewMatchesCell(name: "test1", image: "matchProfile1")
                            NewMatchesCell(name: "test2", image: "maleMock2")
                            //For loop here, will display new matches bubbles
                            // ForEach(0..<newMatches.count) { index in
                            // Text(self.newMatches[index].name)
                            
                            
                            //ForEach(0..<5) { _ in NewMatchesCell()
                            //}
                        }
                    }
                    
                    ListTitleView(title: "Messages")
                    List {
                        
                        //For loop here, will display new matches bubbles
                        ForEach(0..<testMsgCells.count) { index in
                            MessagesCell(userId: self.testMsgCells[index].userId, name: self.testMsgCells[index].name, image: self.testMsgCells[index].image, message: self.testMsgCells[index].message)
                        }
                        //MessagesCell(name: "Jordan1", image: "maleMock3", message: "Hi! Would you like to go on hike at this...")
                        //MessagesCell(name: "Jordan2", image: "logo", message: "Hi cutie :D :D :D!!!")
                    }
                    
                    //For loop here
                    //ForEach(0..<newMatches.count) { index in
                    //  NavigationLink(destination: TestView()){
                    // Text(self.newMatches[index].name)
                }
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                }
            }
            
            
            
        }
        // Spacer()
        
        
        
        
        struct MessageView_Previews: PreviewProvider {
            static var previews: some View {
                MessageView()
            }
        }
