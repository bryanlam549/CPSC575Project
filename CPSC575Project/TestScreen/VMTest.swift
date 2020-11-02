//
//  VMTest.swift
//  CPSC575Project
//
//  Created by bryan lam on 2020-09-29.
//  Copyright © 2020 bryan lam. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class VMtest: ObservableObject{
    @Published var testCollections = [TestCollection]()
    
    private var db = Firestore.firestore()
    
    //Add test data
    func addData(collection: TestCollection){
        do{
            let _ = try db.collection("testCollection").addDocument(from: collection)
        }
        catch{
            print(error)
        }
    }
    
    func fetchData(){
        db.collection("testCollection").addSnapshotListener {(querySnapshot, error) in
            guard let documents = querySnapshot?.documents else{
                print("no documents")
                return
            }
            
            //Using a compact map so whenever we return NIL this gets filtered out by the compact map
            self.testCollections = documents.compactMap{(queryDocumentSnapshot) -> TestCollection? in
                //need to provide class of struct we want to map into
                return try? queryDocumentSnapshot.data(as: TestCollection.self)
                 
 
        
            }
            
        }
    }
    
}
