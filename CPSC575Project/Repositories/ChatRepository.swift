//
//  ChatRepository.swift
//  CPSC575Project
//
//  Created by bryan lam on 2020-11-27.
//  Copyright © 2020 bryan lam. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class ChatRepository: ObservableObject{
    
    let db = Firestore.firestore()
    let userId = Auth.auth().currentUser?.uid
    @Published var chatMessages = [ChatMessageModel]()
    
    init(senderId: String){
        loadData()
    }
    
    func loadData(){
        
    }
}
