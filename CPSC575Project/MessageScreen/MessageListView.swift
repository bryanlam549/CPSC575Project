        //
        //  MessageView.swift
        //  CPSC575Project
        //
        //  Created by bryan lam on 2020-10-18.
        //  Copyright © 2020 bryan lam. All rights reserved.
        //
        
        import SwiftUI
        
        struct MessageListView: View {
            @ObservedObject var messageListVM = MessageListVM()
            //Hardcoded test values
            //let testMsgCells = testMessagesCells
            
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
                            ForEach(messageListVM.messageCellVM) { messageCellVM in
                                MessagesCell(messageCellVM: messageCellVM)
                            }
                        }
                    }
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                }
            }
            
            
            
        }
        // Spacer()
        
        
        
        
        struct MessageView_Previews: PreviewProvider {
            static var previews: some View {
                MessageListView()
            }
        }
