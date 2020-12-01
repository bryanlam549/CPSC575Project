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
            @Binding var buttonPressed: Bool
            @Binding var chatId: String
            @Binding var messageCellVM: MessageCellVM?
            
            
            var body: some View {
                
                Group{
                    VStack{
                        TopView()
                        ListTitleView(title: "New Matches")
                        ScrollView(.horizontal, showsIndicators: false) {
                            // NavigationLink(destination: Text("test")){
                            HStack{
                                Button(action: {
                                    self.buttonPressed.toggle()
                                }) {
                                    NewMatchesCell(name: "test1", image: "matchProfile1")
                                }
                                Button(action: {
                                    self.buttonPressed.toggle()
                                }) {
                                    NewMatchesCell(name: "test2", image: "maleMock2")
                                }
                                
                                
                            }
                        }
                        
                        ListTitleView(title: "Messages")
                        List {
                            
                            ForEach(messageListVM.messageCellVM) { messageCellVM in
                                Button(action: {
                                    //self.chatId = messageCellVM.uid
                                    self.buttonPressed.toggle()
                                    self.messageCellVM = messageCellVM
                                    
                                }) {
                                    MessagesCell(messageCellVM: messageCellVM)
                                }
                            }
                            
                        }
                        
                    }
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                    
                    
                }
                
                
                
            }
            
            
            
        }
        // Spacer()
        
        
        
        
        /*struct MessageView_Previews: PreviewProvider {
         static var previews: some View {
         MessageListView()
         }
         }*/
