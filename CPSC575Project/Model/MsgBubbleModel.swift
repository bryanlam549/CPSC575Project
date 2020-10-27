//
//  MsgBubbleModel.swift
//  CPSC575Project
//
//  Created by bryan lam on 2020-10-18.
//  Copyright © 2020 bryan lam. All rights reserved.
//

import Foundation
import FirebaseFirestoreSwift


//Need UIimage to be codable...
struct MsgBubbleCollection: Identifiable, Codable{
    @DocumentID var id: String? = UUID().uuidString
    //userId?
    var name: String
    //var img: UIImage      //https://programmingwithswift.com/easily-conform-to-codable/
    var previewMsg: String
    
    //in case we use different attribute  name in our firebase database
    /*enum CodingKeys: String, CodingKey{
        case name
        case img
        case previewMsg = something
    }*/
}
    
#if DEBUG

let testMsgBubble = [
    MsgBubbleCollection(name: "Steven", previewMsg: "how ya doin'"),
    MsgBubbleCollection(name: "Stephen", previewMsg: "Marry me!!!"),
    MsgBubbleCollection(name: "Steffan", previewMsg: "what up"),
    MsgBubbleCollection(name: "Steve", previewMsg: "i luv u")
]
#endif

