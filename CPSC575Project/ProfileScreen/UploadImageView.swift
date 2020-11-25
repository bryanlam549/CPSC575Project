////
////  UploadImage.swift
////  CPSC575Project
////
////  Created by Cody Tang  on 2020-11-22.
////  Copyright © 2020 bryan lam. All rights reserved.
////
//
//import Foundation
//import SwiftUI
//import Firebase
//import FirebaseStorage
//import Combine
//
//let FILE_NAME = "Profile Images/" + userID() + ".jpg"
//
//struct UploadImageView: View {
//
//        @State var shown = false
//        @State var imageURL = ""
//
//        var body: some View {
//            VStack {
//                if imageURL != "" {
//                    //Image("profile")
//                    FirebaseImageView(imageURL: imageURL)
//                }
//
//                Button(action: { self.shown.toggle() }) {
//                    Text("Upload Image").font(.title).bold()
//                }.sheet(isPresented: $shown) {
//                    imagePicker(shown: self.$shown,imageURL: self.$imageURL)
//                    }.padding(10).background(Color.purple).foregroundColor(Color.white).cornerRadius(20)
//            }.onAppear(perform: loadImageFromFirebase).animation(.spring())
//        }
//
//        func loadImageFromFirebase() {
//            let storage = Storage.storage().reference(withPath: FILE_NAME)
//            storage.downloadURL { (url, error) in
//                if error != nil {
//                    print((error?.localizedDescription)!)
//                    return
//                }
//                print(userID())
//                print("Download success")
//                self.imageURL = "\(url!)"
//            }
//        }
//    }
//
//    struct UploadImageView_Previews: PreviewProvider {
//        static var previews: some View {
//            UploadImageView()
//        }
//    }
//
//func userID() -> String {
//    let userID : String = (Auth.auth().currentUser?.uid)!
//    return(userID)
//}
