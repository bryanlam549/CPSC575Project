//
//  TestModel.swift
//  CPSC575Project
//
//  Created by bryan lam on 2020-09-29.
//  Copyright © 2020 bryan lam. All rights reserved.
//

import Foundation
import FirebaseFirestoreSwift //To map ID to Document ID

//useful property wrappers:
//DocumentID, ServerTimeStamp, ExplicitNull

struct TestCollection : Identifiable, Codable{//: Codable, Identifiable{
    @DocumentID var id: String? = UUID().uuidString //Whenever we map Document into this struct, it'll read documentID and map it into this ID attribute
    var col1: String
    var col2: String
    var column3: Int
    //@ServerTimestamp var createdTime: Timestamp?
    //var userId: String?
    
    //in case we use different attribute  name in our firebase database
    enum CodingKeys: String, CodingKey{
        case col1
        case col2
        case column3 = "col3"
    }
}

#if DEBUG
let testData = [
    TestCollection(col1: "val1", col2: "valA", column3: 1),
    TestCollection(col1: "val2", col2: "valB", column3: 2),
    TestCollection(col1: "val3", col2: "valC", column3: 3),
    TestCollection(col1: "val4", col2: "valD", column3: 4)
]
#endif
