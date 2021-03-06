        //
        //  ProfileView.swift
        //  CPSC575Project
        //
        //  Created by bryan lam on 2020-10-18.
        //  Copyright © 2020 bryan lam. All rights reserved.
        //
        
        import SwiftUI
        import Firebase
        
        //let FILE_NAME = "Profile Images/" + userID() + ".jpg"
        var downloadedProfileImage = false
        struct ProfileView: View {
            @EnvironmentObject var model: LoginSignUpModel // for testing
            @State var shown = false
            @State var imageURL = ""
            @State var settingsButton = false
            @State var user: User? = nil
            
            
            func loadImageFromFirebase() {
                var file_name = "Profile Images/" + userID() + ".jpg"
                let storage = Storage.storage().reference(withPath: file_name)
                storage.downloadURL { (url, error) in
                    if error != nil {
                        print((error?.localizedDescription)!)
                        return
                    }
                    print(userID())
                    print("Download success")
                    print(self.imageURL)
                    
                    self.imageURL = "\(url!)"
                    
                    
                    
                    
                    //Load url into users2 collection
                    let db = Firestore.firestore()
                    let usersRef = db.collection("users2")
                    let userId = Auth.auth().currentUser?.uid
                    
                    usersRef
                        .whereField("uid", isEqualTo: userId as Any)
                        .addSnapshotListener {(querySnapshot, error) in
                            guard let docu = querySnapshot?.documents else{
                                print("no documents")
                                return
                            }
                            
                            //Assign ids of users you've been matched to
                            for d in docu {
                                let docID = d.documentID
                                //let x = try document.data(as: User.self)
                                do{
                                    self.user = try d.data(as: User.self)
                                }
                                catch{
                                    print(error)
                                }
                                
                                usersRef.document(docID).updateData(["imageUrl1": self.imageURL]) { (err) in
                                    
                                    if err != nil{
                                        print(err as Any)
                                        return
                                    }
                                    
                                    //print("saved in users2")
                                    
                                }
                            }
                            
                    }
                    
                }
            }
            
            var body: some View {
                VStack{
                    //TopView().padding(.bottom)
                    if(settingsButton){
                        SignOut(backButtonPressed: $settingsButton)
                    }else{
                        ZStack{
                        //Image("profile").resizable().edgesIgnoringSafeArea(.all).blur(radius: 80)
                        GeometryReader { geo in
                            VStack {
                                TopView().padding(.bottom).offset(y: -10)
                                Spacer()//.frame(height: 30)
                                HStack{Text("Profile")
                                    .font(.title)
                                    .fontWeight(.bold)}.offset(y:40)
                                //Spacer().frame(height: 20)
                                ZStack {
                                    //loadImageFromFirebase()
                                    if downloadedProfileImage == false {
                                        Image("profile").resizable()
                                            .frame(width: geo.size.width / 1.5, height: geo.size.width / 1.5, alignment: .center)
                                            .cornerRadius((geo.size.width / 1.5) / 2)
                                    }
                                    if self.imageURL != "" {FirebaseImageView(imageURL: self.imageURL)}
                                    VStack {
                                        Spacer()
                                        HStack {
                                            Spacer()
                                            //                                            Button(action: self.profileEditButtonTapped) {
                                            //                                                Text("Edit")
                                            //                                            }
                                        }
                                    }
                                    
                                }
                                    //                                                        .frame(width: geo.size.width / 1.5, height: geo.size.width / 1.5, alignment: .center)
                                    //                                                        .padding(.bottom, 10)
                                    .frame(
                                        width: geo.size.width / 1.1,
                                        height: geo.size.width / 1.1,
                                        alignment: .center
                                ).padding(.bottom, 10)
                                
                                //                                Text("Jane Doe, 22")
                                //                                    .font(.title)
                                //                                    .fontWeight(.bold)
                                //
                                //                                Text("Business Studnet @ UofC\n\nI love my dogs and staying active:)\n\nContact me ").padding().lineLimit(6)
                                //                                Spacer()
                                Spacer()//.frame(height:40)
                                
                                ZStack(alignment: .top) {
                                    VStack{
                                        HStack{
                                            VStack(alignment: .leading, spacing: 10) {
                                                Text((self.user?.name ?? "") + ", " + "\(self.user?.age ?? 18)")
                                            }
                                            .padding(10)
                                                //.padding(.top,30)
                                                .font(.title)
                                            Spacer()
                                            HStack(spacing: 8) {
                                                Image("map").resizable().frame(width: 20, height: 20)
                                                Text("0 km").font(Font.system(size:18, design: .default))
                                            }.padding(10)
                                                .background(Color.black.opacity(0.1))
                                                .cornerRadius(10)
                                        }.padding(10)
                                            .padding(.top, 30)
                                        Text(self.user?.bio ?? "")
                                            .padding(10)
                                            .font(Font.system(size:18, design: .default))
                                    }
                                    .background(Blurview())
                                    .clipShape(BottomShape())
                                    .cornerRadius(25)
                                    .shadow(radius: 3)
                                    
                                    ZStack{
                                        Button(action: {
                                            self.shown.toggle()
                                        }) {
                                            Image("camera")
                                                .renderingMode(.original)
                                                .resizable()
                                                .frame(width: 35, height: 35)
                                                .padding(15)
                                                //.background(Color.black.opacity(0.1))
                                                .background(Blurview())
                                                //.background(Color.white)
                                                .clipShape(Circle())
                                        }.sheet(isPresented: self.$shown) {imagePicker(shown: self.$shown,imageURL: self.$imageURL)}
                                        
                                        Circle().stroke(Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)), lineWidth: 5).frame(width: 70, height: 70)
                                    }.offset(y: -35).onAppear(perform: self.loadImageFromFirebase).animation(.spring())
                                    
                                    HStack{
                                        ZStack{
                                            Button(action: {
                                                self.settingsButton.toggle()
                                            }) {
                                                Image("gear")
                                                    .renderingMode(.original)
                                                    .resizable()
                                                    .frame(width: 35, height: 35)
                                                    .padding(15)
                                                    .background(Blurview())
                                                    .clipShape(Circle())
                                            }
                                            Circle().stroke(Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)), lineWidth: 5).frame(width: 70, height: 70)
                                        }
                                        Spacer()
                                        
                                        ZStack{
                                            Button(action: {
                                                
                                            }) {
                                                Image("edit")
                                                    .renderingMode(.original)
                                                    .resizable()
                                                    .frame(width: 35, height: 35)
                                                    .padding(15)
                                                    .background(Blurview())
                                                    .clipShape(Circle())
                                            }
                                            Circle().stroke(Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)), lineWidth: 5).frame(width: 70, height: 70)
                                        }
                                    }.offset(y: -35)
                                        .padding(.horizontal, 55)
                                }
                            }
                        }.padding(10)
                    }
                    }
                    
                    //                    func profileEditButtonTapped() {
                    //                        print("Profile Edit Button tapped...")
                    //                    }
                }
            }
            
        }
        
        struct ProfileView_Previews: PreviewProvider {
            static var previews: some View {
                Group {
                    ProfileView()
                    ProfileView()
                        .previewDevice("iPhone 11")
                }
            }
        }
        
        struct BottomShape : Shape {
            func path(in rect: CGRect) -> Path {
                
                return Path{path in
                    path.move(to: CGPoint(x: 0, y: 0))
                    path.addLine(to: CGPoint(x: 0, y: rect.height))
                    path.addLine(to:CGPoint(x: rect.width, y: rect.height))
                    path.addLine(to: CGPoint(x: rect.width, y:0))
                    path.addArc(center: CGPoint(x: rect.width / 2, y: 0), radius: 35, startAngle: .zero, endAngle:  .init(degrees: 180), clockwise: false)
                }
            }
        }
        
        struct Blurview : UIViewRepresentable {
            func makeUIView(context: UIViewRepresentableContext<Blurview>) ->
                UIVisualEffectView {
                    let view = UIVisualEffectView(effect: UIBlurEffect(style:
                        .systemUltraThinMaterialLight))
                    return view
            }
            
            func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Blurview>) {
                
            }
        }
        
        func userID() -> String {
            let userID : String = Auth.auth().currentUser?.uid ?? ""//(Auth.auth().currentUser?.uid)!
            return(userID)
        }
        
