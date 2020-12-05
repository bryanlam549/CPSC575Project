//
//  VMTest.swift
//  CPSC575Project
//
//  Created by bryan lam on 2020-11-09.
//  Copyright © 2020 bryan lam. All rights reserved.
//

import Foundation
import Combine
import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift


// ChatController needs to be a ObservableObject in order
// to be accessible by SwiftUI
class ChatRowVM : ObservableObject {
    // didChange will let the SwiftUI know that some changes have happened in this object
    // and we need to rebuild all the views related to that object
    var didChange = PassthroughSubject<Void, Never>()
    
    // We've relocated the messages from the main SwiftUI View. Now, if you wish, you can handle the networking part here and populate this array with any data from your database. If you do so, please share your code and let's build the first global open-source chat app in SwiftUI together
    // It has to be @Published in order for the new updated values to be accessible from the ContentView Controller
    /*@Published var messages = [
     ChatMessageModel(message: "Hello world", avatar: "A", color: .red),
     ChatMessageModel(message: "Hi", avatar: "B", color: .blue)
     ]*/
    
    @Published var messages = [ChatMessageModel]()
    private var db = Firestore.firestore()
    var senderId: String
    let userId = Auth.auth().currentUser?.uid
    var avatar: String
    var selfUser: User? = nil
    
    init(senderId: String, avatar: String){
        self.senderId = senderId
        self.avatar = avatar
        getSelfUser()
        
    }
    
    func getSelfUser(){
        let usersRef = self.db.collection("users2")
        usersRef
            .whereField("uid", isEqualTo: self.userId as Any)
            //.getDocuments(completion: { snapshot, error in
            .addSnapshotListener {(snapshot, error) in
                guard let documents = snapshot?.documents else {
                    print("Collection was empty")
                    return
                }
                
                
                var _ = documents.compactMap{(queryDocumentSnapshot) -> User? in
                    self.selfUser = try? queryDocumentSnapshot.data(as:User.self)
                    return self.selfUser
                }
                
            }
    }
    
    func sendMessage(_ chatMessage: ChatMessageModel) {
        let chatsRef = self.db.collection("chats")
        
        chatsRef
        .whereField("users", in: [[userId as Any, senderId as Any], [senderId as Any, userId as Any]])
        //.getDocuments(completion: { snapshot, error in
        .addSnapshotListener {(snapshot, error) in
            guard let documents = snapshot?.documents else {
                print("Collection was empty")
                return
            }
            
            
            for doc in documents {
                let docID = doc.documentID
                let eachChannelRef = chatsRef.document(docID)
                let messagesRef = eachChannelRef.collection("messages")
                do{
                    if(chatMessage.message != ""){
                        let _ = try messagesRef.addDocument(from: chatMessage)
                    }
                }
                catch{
                    print(error)
                }
            }
        }
        
        
        // here we populate the messages array
        //messages.append(chatMessage)
        // here we let the SwiftUI know that we need to rebuild the views
        //didChange.send(())
    }
    
    func fetchData(){
        
        let chatsRef = self.db.collection("chats")
        
        chatsRef
            .whereField("users", in: [[userId as Any, senderId as Any], [senderId as Any, userId as Any]])
            //.getDocuments(completion: { snapshot, error in
            .addSnapshotListener {(snapshot, error) in
                guard let documents = snapshot?.documents else {
                    print("Collection was empty")
                    return
                }
                
                
                for doc in documents {
                    let docID = doc.documentID
                    let eachChannelRef = chatsRef.document(docID)
                    let messagesRef = eachChannelRef.collection("messages")
                    
                    
                    messagesRef
                        .order(by: "createdTime", descending: true)
                        .addSnapshotListener {(querySnapshot, error) in
                            guard let docu = querySnapshot?.documents else{
                                print("no documents")
                                return
                            }
                            
                            //Using a compact map so whenever we return NIL this gets filtered out by the compact map
                            self.messages = docu.compactMap{(queryDocumentSnapshot) -> ChatMessageModel? in
                                let x = try? queryDocumentSnapshot.data(as: ChatMessageModel.self)
                                
                                
                                if (x?.userId == self.userId){
                                    let usersRef = self.db.collection("users2")
                                    usersRef
                                        .whereField("uid", isEqualTo: self.userId as Any)
                                        //.getDocuments(completion: { snapshot, error in
                                        .addSnapshotListener {(snapshot, error) in
                                            guard let documents = snapshot?.documents else {
                                                print("Collection was empty")
                                                return
                                            }
                                            
                                            
                                            var _ = documents.compactMap{(queryDocumentSnapshot) -> User? in
                                                self.selfUser = try? queryDocumentSnapshot.data(as:User.self)
                                                return self.selfUser
                                            }
                                            
                                        }
                                    return ChatMessageModel(id: x?.id ?? "", userId: x?.userId ?? "", message: x?.message ?? "", avatar: self.selfUser?.imageUrl1 ?? "person", createdTime: x?.createdTime ?? nil)
                                }
                                else{
                                    //If message is from other user
                                    return ChatMessageModel(id: x?.id ?? "", userId: x?.userId ?? "", message: x?.message ?? "", avatar: self.avatar, createdTime: x?.createdTime ?? nil)
                                }
                                
                                
                                
                            }
                            
                    }
                    
                    
                }
                
        }
        
        /*db.collection("chats")
            .order(by: "createdTime", descending: false)
            .whereField("users", arrayContains: userId as Any)*/
        //.whereField("users", arrayContains: senderId as Any)
        
        
    }
    
    
    
}
