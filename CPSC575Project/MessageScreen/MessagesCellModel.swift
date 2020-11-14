//
//  MessagesCellModel.swift
//  CPSC575Project
//
//  Created by Selma Novl on 2020-10-29.
//  Copyright © 2020 bryan lam. All rights reserved.
//

import Foundation
import Foundation
struct MessagesCellModel {
    let userId: String
    let name: String
    let image: String
    let message: String
}

#if DEBUG
let testMessagesCells = [
    MessagesCellModel(userId: "1", name: "Jordan1", image: "maleMock3", message: "Hi! Would you like to go on hike at this..."),
    MessagesCellModel(userId: "2", name: "Jordan2", image: "logo", message: "how YOU doin'")
]
#endif
