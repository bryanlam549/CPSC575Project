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
            @Binding var messageCellVM: MessageCellVM?
            
            
            var body: some View {
                
                Group{
                    VStack{
                        TopView()
                        ListTitleView(title: "New Matches")
                        ScrollView(.horizontal, showsIndicators: false) {
                            // NavigationLink(destination: Text("test")){
                            HStack(){
                                //Text("???")
                                ForEach(messageListVM.messageCellVM) { messageCellVM in
                                    if (messageCellVM.message == "") {
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
                        }.id(UUID().uuidString)
                        
                        ListTitleView(title: "Messages")
                        List {
                            
                            ForEach(messageListVM.messageCellVM) { messageCellVM in
                                if (messageCellVM.message != "") {
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
                        
                    }
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                    
                    
                }
                
            }
        }
