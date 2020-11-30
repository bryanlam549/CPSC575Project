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
    
    
    
    init(){
        LoadMatchedUsers()
        LoadUsers()
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
        
        
        //print(matchedUsers[0].uid)
        //print(matchedUsers[1].uid)
        //.order(by: "createdTime")
        //.whereField("userId", isEqualTo: userId as Any)
        
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
        
        
        
        /*.addSnapshotListener { (querySnapshot, error) in
         if let querySnapshot = querySnapshot {
         self.testStrings = querySnapshot.documents.compactMap { document in
         do{
         //Right here... you're returning users from firestore
         let x = try document.data(as: String.self)
         print("hi")
         print(x as Any)
         return x
         }
         catch{
         print("hi")
         print(error)
         }
         return nil
         }
         }
         }*/
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
