//
//  UserRepository.swift
//  CPSC575Project  
//
//  Created by bryan lam on 2020-11-16.
//  Copyright © 2020 bryan lam. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class UserRepository: ObservableObject{
    
    let db = Firestore.firestore()
    @Published var users = [User]()
    @Published var matchedUsers = [User]()
    @Published var matchedUsersId = [String]()
    
    @Published var messageBubble = [ChatMessageModel]()
    //@Published var recentMessage: ChatMessageModel? = nil
    @Published var messageCellModel = [MessagesCellModel]()
    
    
    init(){
        LoadMatchedUsers()
        LoadUsers()
        LoadMessageRow()
    }
    
    func LoadUsers(){
        //let userId = Auth.auth().currentUser?.uid
        //set up a snapshot listener that listens
        db.collection("users2")
            .addSnapshotListener { (querySnapshot, error) in
                if let querySnapshot = querySnapshot {
                    /*DEBUG
                     for d in querySnapshot.documents{
                     print(d.documentID)
                     }*/
                    self.users = querySnapshot.documents.compactMap { document in
                        do{
                            let x = try document.data(as: User.self)
                            return x
                        }
                        catch{
                            print(error)
                        }
                        return nil
                    }
                }
        }
    }
    
    func LoadMatchedUsers(){
        var userId = Auth.auth().currentUser?.uid
        if (userId == nil){
            userId = ""
        }
        db.collection("chats")
            .whereField("users", arrayContainsAny: [userId as Any])
            .addSnapshotListener {(querySnapshot, error) in
                guard let docu = querySnapshot?.documents else{
                    print("no documents")
                    return
                }
                
                //Assign ids of users you've been matched to
                for d in docu {
                    let docUserIdPair: [String] = d.get("users") as! [String]
                    for docUserId in docUserIdPair{
                        if (!self.matchedUsersId.contains(docUserId) && docUserId != userId){
                            self.matchedUsersId.append(docUserId)
                        }
                    }
                }
                //print(Auth.auth().currentUser?.uid)
                //print(self.testStrings)
                
                //Need to append "" when no matches, or else error
                if self.matchedUsersId.count == 0{
                    self.matchedUsersId.append("")
                }
                
                //Pull matched users
                self.db.collection("users2")
                    //.whereField("uid", arrayContainsAny: ["MWP2iMrkdLYB8t2bGeLwIm3EQiD3"])
                    .whereField("uid", in: self.matchedUsersId)
                    
                    .addSnapshotListener { (querySnapshot, error) in
                        if let querySnapshot = querySnapshot {
                            /*DEBUG
                             for d in querySnapshot.documents{
                             print(d.documentID)
                             }*/
                            self.matchedUsers = querySnapshot.documents.compactMap { document in
                                do{
                                    let x = try document.data(as: User.self)
                                    return x
                                }
                                catch{
                                    print(error)
                                }
                                return nil
                            }
                            //print(self.matchedUsers)
                        }
                }
        }
    }
    func LoadMessageRow(){
        var userId = Auth.auth().currentUser?.uid
        
        //Check if user is logged in, bug if we leave userId as nil
        if (userId == nil){
            userId = ""
        }
        //Check Firstbase Chats
        let chatsRef = self.db.collection("chats")
        chatsRef
            .whereField("users", arrayContainsAny: [userId as Any])
            .addSnapshotListener {(querySnapshot, error) in
                guard let docu = querySnapshot?.documents else{
                    print("no documents")
                    return
                }
                
                //Assign ids of users you've been matched to
                for d in docu {
                    //populate matchUsersId
                    let docUserIdPair: [String] = d.get("users") as! [String]
                    for docUserId in docUserIdPair{
                        //Check if user is yourself, don't append to list and also check for duplicates
                        if (!self.matchedUsersId.contains(docUserId) && docUserId != userId){
                            self.matchedUsersId.append(docUserId)
                        }
                    }
                    
                }
                
                //if Zero matches, must append empty or else error occurs
                if self.matchedUsersId.count == 0{
                    self.matchedUsersId.append("")
                }
                
                //Grab users from match list and bind it matchUsers list
                self.db.collection("users2")
                    .whereField("uid", in: self.matchedUsersId)
                    .addSnapshotListener { (querySnapshot, error) in
                        if let querySnapshot = querySnapshot {
                            self.matchedUsers = querySnapshot.documents.compactMap { document in
                                do{
                                    let user = try document.data(as: User.self)
                                    //print(user?.name as Any)
                                    self.db.collection("chats")
                                        .whereField("users", in: [[userId as Any, user?.uid as Any], [user?.uid as Any, userId as Any]])
                                        .addSnapshotListener {(querySnapshot, error) in
                                            guard let doc = querySnapshot?.documents else{
                                                print("no documents")
                                                return
                                            }
                                            
                                            
                                            for d in doc{
                                                let docID = d.documentID
                                                let eachChannelRef = chatsRef.document(docID)
                                                let messagesRef = eachChannelRef.collection("messages")
                                                
                                                messagesRef
                                                    .order(by: "createdTime", descending: true)
                                                    //.whereField("users", arrayContainsAny: [user?.uid as Any])
                                                    .limit(to: 1)
                                                    .addSnapshotListener {(querySnapshot, error) in
                                                        if let querySnapshot = querySnapshot {
                                                            
                                                            if(querySnapshot.count == 0){
                                                                self.messageCellModel.append(MessagesCellModel(userId: user!.uid!, name: user!.name, image: user!.imageUrl1, message: ""))
                                                                /*do{
                                                                    let _ = try messagesRef.addDocument(from: ChatMessageModel(message: "", avatar: "c"))
                                                                }
                                                                catch{
                                                                    print(error)
                                                                }*/
                                                                
                                                            }
                                                            self.messageBubble = querySnapshot.documents.compactMap { document in
                                                                do{
                                                                    //Replace recent message
                                                                    for i in 0..<self.messageCellModel.count {
                                                                        if(self.messageCellModel[i].userId == user?.uid){
                                                                            self.messageCellModel.remove(at: i)
                                                                            break
                                                                        }
                                                                    }
                                                                    
                                                                    let chatMessage = try document.data(as: ChatMessageModel.self)
                                                                    //store results, either in either list, depending on
                                                                    
                                                                    
                                                                    
                                                                    self.messageCellModel.append(MessagesCellModel(userId: user!.uid!, name: user!.name, image: user!.imageUrl1, message: chatMessage!.message))
                                                                
                                                                    return chatMessage
                                                                }
                                                                catch{
                                                                    print(error)
                                                                }
                                                                return nil
                                                            }
                                                            
                                                            
                                                        }
                                                }
                                            }
                                            
                                    }
                                    return user
                                }
                                catch{
                                    print(error)
                                }
                                return nil
                            }
                        }
                        
                }
        }
        
        
    
    }
    
    
    func addTask(_ user: User){
        do{
            var addedUser = user
            addedUser.uid = Auth.auth().currentUser?.uid
            let _ = try db.collection("users2").addDocument(from: addedUser)
        }
        catch{
            fatalError("Unable to encode task: \(error.localizedDescription)")
        }
        
    }
}
