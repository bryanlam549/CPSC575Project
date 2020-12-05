//
//  User.swift
//  CPSC575Project
//
//  Created by bryan lam on 2020-10-25.
//  Copyright © 2020 bryan lam. All rights reserved.
//

import Foundation
import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift


struct User: Codable, Identifiable {

// MARK: - Properties
    
    @DocumentID var id: String?
    var uid: String?
    var email: String = ""
    
    var name: String = ""
    var age: Int = 18
    var bio: String = ""
    var imageUrl1: String = ""
    var imageUrl2: String = ""
    var imageUrl3: String = ""
    var profession: String = ""
    var minSeekingAge: Int = 18
    var maxSeekingAge: Int = 50
    
    var rejected = [String]()
    var liked = [String]()
    var status = ""
    
}
