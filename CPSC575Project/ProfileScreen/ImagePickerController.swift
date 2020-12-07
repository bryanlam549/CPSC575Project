//
//  ImagePickerController.swift
//  CPSC575Project
//
//  Created by Cody Tang  on 2020-11-22.
//  Copyright © 2020 bryan lam. All rights reserved.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseStorage
import Combine

struct imagePicker: UIViewControllerRepresentable {
    
    @Binding var shown: Bool
    @Binding var imageURL:String
    //@EnvironmentObject var dl: downloadState
    
    func makeCoordinator() -> imagePicker.Coordinator {
        return imagePicker.Coordinator(parent: self)
    }
    
    class Coordinator: NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
        var parent: imagePicker
        let storage = Storage.storage().reference()
        init(parent: imagePicker) {
            self.parent = parent
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.shown.toggle()
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let image = info[.originalImage] as! UIImage
            uploadImageToFireBase(image: image)
        }
        
        func uploadImageToFireBase(image: UIImage) {
            // Create the file metadata
            let metadata = StorageMetadata()
            let file_name = "Profile Images/" + userID() + ".jpg"
            metadata.contentType = "image/jpeg"
            
            // Upload the file to the path FILE_NAME
            storage.child(file_name).putData(image.jpegData(compressionQuality: 0.42)!, metadata: metadata) { (metadata, error) in
                guard let metadata = metadata else {
                  // Uh-oh, an error occurred!
                  print((error?.localizedDescription)!)
                  return
                }
                // Metadata contains file metadata such as size, content-type.
                let size = metadata.size
                
                print("Upload size is \(size)")
                print("Upload success")
                self.downloadImageFromFirebase()
            }
        }
        
        func downloadImageFromFirebase() {
            // Create a reference to the file you want to download
            let file_name = "Profile Images/" + userID() + ".jpg"
            storage.child(file_name).downloadURL { (url, error) in
                if error != nil {
                    // Handle any errors
                    print((error?.localizedDescription)!)
                    return
                }
                print("Download success")
                downloadedProfileImage = true
                print(downloadedProfileImage)
                self.parent.imageURL = "\(url!)"
                print(self.parent.imageURL)
                updateImageInDB(url: self.parent.imageURL)
                self.parent.shown.toggle()
                
                self.listOfImageFile()
            }
        }
        
        func listOfImageFile() {
            let storageReference = Storage.storage().reference().child("Profile Images/")
            storageReference.listAll { (result, error) in
              if error != nil {
                  // Handle any errors
                  print((error?.localizedDescription)!)
                  return
              }
              for prefix in result.prefixes {
                // The prefixes under storageReference.
                // You may call listAll(completion:) recursively on them.
                print("prefix is \(prefix)")
              }
              for item in result.items {
                // The items under storageReference.
                print("items is \(item)")
              }
            }
        }
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<imagePicker>) -> UIImagePickerController {
        let imagepic = UIImagePickerController()
        imagepic.sourceType = .photoLibrary
        imagepic.delegate = context.coordinator
        return imagepic
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<imagePicker>) {
    }
}

func updateImageInDB(url : String) {
    let db = Firestore.firestore()
    let users = db.collection("users2")
    users.whereField("uid", isEqualTo: userID()).limit(to: 1).getDocuments(completion: {
        querySnapshot, error in
        if let err = error {
            print(err.localizedDescription)
            return
        }
        
        guard let docs = querySnapshot?.documents else {return}
        
        for doc in docs {
            let docId = doc.documentID
            let name = doc.get("name")
            print(docId, name)
            
            let ref = doc.reference
            ref.updateData(["imageUrl1": url])
        }
    })
}
