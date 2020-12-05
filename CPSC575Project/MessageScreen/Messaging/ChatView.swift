//
//  ChatView.swift
//  CPSC575Project
//
//  Created by bryan lam on 2020-11-09.
//  Copyright © 2020 bryan lam. All rights reserved.
//

import Foundation
import SwiftUI

struct ChatView : View {
    
    //var senderId: String
     // @State here is necessary to make the composedMessage variable accessible from different views
    @State var composedMessage: String = ""
    @ObservedObject var chatRowVM: ChatRowVM// = VMChatRow(senderId: "1")
    @Binding var buttonPressed: Bool
    
    
    var body: some View {
      
        // the VStack is a vertical stack where we place all our substacks like the List and the TextField
        VStack {
            Button(action: {
                self.buttonPressed.toggle()
            }) {
                Text("Back button")
            }
            
            List(chatRowVM.messages){ msg in
                ChatRowView(chatMessage: msg)
                .rotationEffect(.radians(.pi))
                .scaleEffect(x: -1, y: 1, anchor: .center)
            }
            .rotationEffect(.radians(.pi))
            .scaleEffect(x: -1, y: 1, anchor: .center)
            .onAppear(){
                self.chatRowVM.fetchData()
            }
            
            // TextField are aligned with the Send Button in the same line so we put them in HStack
            HStack {
                // this textField generates the value for the composedMessage @State var
                TextField("Message...", text: $composedMessage).frame(minHeight: CGFloat(30))
                // the button triggers the sendMessage() function written in the end of current View
                Button(action: {
                    self.chatRowVM.sendMessage(ChatMessageModel(message: self.composedMessage.trimmingCharacters(in: .whitespacesAndNewlines), avatar: "C"))
                    self.composedMessage = ""
                }) {
                    Text("Send")
                }
            }.frame(minHeight: CGFloat(50)).padding()
            // that's the height of the HStack
        }
    }
}
