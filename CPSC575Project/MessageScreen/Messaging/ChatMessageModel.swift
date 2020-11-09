//
//  ChatMessageModel.swift
//  CPSC575Project
//
//  Created by bryan lam on 2020-11-09.
//  Copyright © 2020 bryan lam. All rights reserved.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift //To map ID to Document ID

// let's create a structure that will represent each message in chat
struct ChatMessageModel : Identifiable, Codable, Hashable {
    @DocumentID var id: String? = UUID().uuidString
    var message: String
    var avatar: String
    //var color: Color
     // isMe will be true if We sent the message
    var isMe: Bool = false
}
