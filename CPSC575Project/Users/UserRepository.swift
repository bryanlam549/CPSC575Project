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
    
    init(){
        loadData()
    }
    
    func loadData(){
        let userId = Auth.auth().currentUser?.uid
        
        //set up a snapshot listener that listens
        db.collection("users2")
            //.order(by: "createdTime")
            .whereField("userId", isEqualTo: userId as Any)
            .addSnapshotListener { (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
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
