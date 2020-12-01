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
    
    init(senderId: String){
        self.senderId = senderId
    }
    
    // this function will be accessible from SwiftUI main view
    // here you can add the necessary code to send your messages not only to the SwiftUI view, but also to the database so that other users of the app would be able to see it
    /*func sendMessage(_ chatMessage: ChatMessageModel) {
        
        do{
            let _ = try db.collection("chat").addDocument(from: chatMessage)
        }
        catch{
            print(error)
        }
        // here we populate the messages array
        //messages.append(chatMessage)
        // here we let the SwiftUI know that we need to rebuild the views
        //didChange.send(())
    }*/
    
    /*func fetchData(){
        let userId = Auth.auth().currentUser?.uid
        
        db.collection("chat")
            .order(by: "createdTime", descending: false)
            .whereField("userId", isEqualTo: userId as Any)
            .whereField("senderId", isEqualTo: senderId as Any)
            .addSnapshotListener {(querySnapshot, error) in
                guard let documents = querySnapshot?.documents else{
                    print("no documents")
                    return
                }
                
                //Using a compact map so whenever we return NIL this gets filtered out by the compact map
                self.messages = documents.compactMap{(queryDocumentSnapshot) -> ChatMessageModel? in
                    //need to provide class of struct we want to map into
                    return try? queryDocumentSnapshot.data(as: ChatMessageModel.self)
                    
                    
                    
                }
                
        }
        
    }*/
    
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
                        .order(by: "createdTime", descending: false)
                        
                        .addSnapshotListener {(querySnapshot, error) in
                            guard let docu = querySnapshot?.documents else{
                                print("no documents")
                                return
                            }
                            
                            /*for d in docu {
                                
                               //print(d.documentID)
                                print(d.get("userId"))
                                //print(d.data())
                            }*/
                            
                            //Using a compact map so whenever we return NIL this gets filtered out by the compact map
                            self.messages = docu.compactMap{(queryDocumentSnapshot) -> ChatMessageModel? in
                                //need to provide class of struct we want to map into
                                return try? queryDocumentSnapshot.data(as: ChatMessageModel.self)
                                
                                
                                
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
