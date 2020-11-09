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
    
     // @State here is necessary to make the composedMessage variable accessible from different views
    @State var composedMessage: String = ""
    @EnvironmentObject var chatController: VMChatRow
    
    
    var body: some View {
      
        // the VStack is a vertical stack where we place all our substacks like the List and the TextField
        VStack {
            // I've removed the text line from here and replaced it with a list
            // List is the way you should create any list in SwiftUI
            List {
                // we have several messages so we use the For Loop
                ForEach(chatController.messages, id: \.self) { msg in
                    ChatRowView(chatMessage: msg)
                }
            }
            
            // TextField are aligned with the Send Button in the same line so we put them in HStack
            HStack {
                // this textField generates the value for the composedMessage @State var
                TextField("Message...", text: $composedMessage).frame(minHeight: CGFloat(30))
                // the button triggers the sendMessage() function written in the end of current View
                Button(action: {
                    self.chatController.sendMessage(ChatMessageModel(message: self.composedMessage, avatar: "C", color: .green, isMe: true))
                    self.composedMessage = ""
                }) {
                    Text("Send")
                }
            }.frame(minHeight: CGFloat(50)).padding()
            // that's the height of the HStack
        }
    }
}