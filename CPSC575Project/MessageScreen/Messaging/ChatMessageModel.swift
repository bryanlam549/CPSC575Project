//
//  ChatMessageModel.swift
//  CPSC575Project
//
//  Created by bryan lam on 2020-11-09.
//  Copyright © 2020 bryan lam. All rights reserved.
//

import Foundation
import SwiftUI

// let's create a structure that will represent each message in chat
struct ChatMessageModel : Hashable {
    var message: String
    var avatar: String
    var color: Color
     // isMe will be true if We sent the message
    var isMe: Bool = false
}
