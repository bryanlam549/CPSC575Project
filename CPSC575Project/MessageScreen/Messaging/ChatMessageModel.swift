//
//  ChatMessageModel.swift
//  CPSC575Project
//
//  Created by bryan lam on 2020-11-09.
//  Copyright © 2020 bryan lam. All rights reserved.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift //To map ID to Document ID
import Firebase

// let's create a structure that will represent each message in chat
struct ChatMessageModel : Identifiable, Codable, Hashable {
    @DocumentID var id: String? = UUID().uuidString //FirebaseAuth.Auth.auth().currentUser
    var userId = FirebaseAuth.Auth.auth().currentUser?.uid
    var senderId = 1    //Should be the sender's uid
    
    var message: String
    var avatar: String
    var isMe: Bool = false
    
    @ServerTimestamp var createdTime: Timestamp?
}
