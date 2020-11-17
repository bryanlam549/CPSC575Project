//
//  ChatRow.swift
//  
//
//  Created by bryan lam on 2020-11-09.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

// ChatRow will be a view similar to a Cell in standard Swift
struct ChatRowView : View {
    // we will need to access and represent the chatMessages here
    var chatMessage: ChatMessageModel
    let userId = Auth.auth().currentUser?.uid
    // body - is the body of the view, just like the body of the first view we created when opened the project
    var body: some View {
        // HStack - is a horizontal stack. We let the SwiftUI know that we need to place
        // all the following contents horizontally one after another
        Group {
            if chatMessage.userId != self.userId{
                HStack {
                    Group {
                        Text(chatMessage.avatar)
                        Text(chatMessage.message)
                            .bold()
                            .padding(10)
                            .foregroundColor(Color.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
            } else {
                HStack {
                    Group {
                        Spacer()
                        Text(chatMessage.message)
                            .bold()
                            .foregroundColor(Color.white)
                            .padding(10)
                            .background(Color.red)
                        .cornerRadius(10)
                        Text(chatMessage.avatar)
                    }
                }
            }
        }

    }
}
