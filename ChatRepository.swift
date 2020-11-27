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
        loadData(senderId: senderId)
    }
    
    func loadData(senderId: String){
        //var userId = Auth.auth().currentUser?.uid
        let chatsRef = self.db.collection("chats")
        
        //Check Firstbase Chats
        chatsRef
            .whereField("users", arrayContainsAny: [userId as Any])
            .addSnapshotListener {(querySnapshot, error) in
                guard let document = querySnapshot?.documents else{
                    print("no documents")
                    return
                }
                
                //Assign ids of users you've been matched to
                for doc in document {
                    //Populate chatMessages array
                    let docID = doc.documentID
                    let eachChannelRef = chatsRef.document(docID)
                    let messagesRef = eachChannelRef.collection("messages")
                    
                    messagesRef
                        .order(by: "createdTime", descending: false)
                        .whereField("senderId", arrayContainsAny: [senderId as Any])
                        .addSnapshotListener {(querySnapshot, error) in
                            guard let docu = querySnapshot?.documents else{
                                print("no documents")
                                return
                            }
                            
                            //Using a compact map so whenever we return NIL this gets filtered out by the compact map
                            self.chatMessages = docu.compactMap{(queryDocumentSnapshot) -> ChatMessageModel? in
                                //need to provide class of struct we want to map into
                                return try? queryDocumentSnapshot.data(as: ChatMessageModel.self)
                            }
                            
                    }
                    
                    
                }
                
        }
        
        
        
    }
}
