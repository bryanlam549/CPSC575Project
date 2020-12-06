//
//  MatchView.swift
//  CPSC575Project
//
//  Created by bryan lam on 2020-10-18.
//  Copyright © 2020 bryan lam. All rights reserved.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct MatchView: View {
    @EnvironmentObject var obs : observer
    var body: some View {
        
        ZStack{
            Color("LightWhite").edgesIgnoringSafeArea(.all)
            if obs.users.isEmpty{
                Loader()
            }
            Loader()
            VStack{
                TopView().padding(.bottom)
                //Spacer().frame(height: 30)
                //TopMatchView()
                SwipeMatchView()
                Spacer()
                BottomMatchView().padding(.bottom)
                Spacer()
            }
        }
    }
}

struct MatchView_Previews: PreviewProvider {
    static var previews: some View {
        MatchView()
    }
}

struct TopMatchView : View {
    var body : some View{
        HStack{
            Button(action: {
                
            }) {
                Image("person").resizable().frame(width: 35, height: 35)
            }.foregroundColor(.gray)
            
            Spacer()
            
            Button(action: {
                
            }) {
                Image(systemName: "flame.fill").resizable().frame(width: 30, height: 35)
            }.foregroundColor(.red)
            
            Spacer()
            
            Button(action: {
                
            }) {
                Image("chat").resizable().frame(width: 35, height: 35)
            }.foregroundColor(.gray)
            
            
        }.padding()
    }
}

struct BottomMatchView : View {
    @EnvironmentObject var obs : observer
    var body : some View{
        HStack{
            Spacer()
            //Redo button commented out
//            Button(action:{
//                if self.obs.last != -1 {
//                    //self.obs.updateDB(id: self.obs.users[self.obs.last], status: "")
//                    //self.obs.goBack(index: self.obs.last)
//                }
//            }) {
//                    Image("reload").resizable().frame(width: 25, height: 25).padding()}
//                    .foregroundColor(.yellow)
//                    .background(Color.white)
//                    .shadow(radius: 25)
//                    .clipShape(Circle())
//
            
            // Clear button commented out for now
//            Button(action:{
//                //current = self.obs.last
//                if self.obs.last == -1 {
//                    //self.obs.updateDB(id: self.obs.users[self.obs.users.count-1], status: "reject")
//                    self.obs.updateDB(id: self.obs.users[self.obs.users.count-1], status: "reject")
//                    //before swipe
//                    print("bug testing: before swipe")
//                }
//                else {
//                    //self.obs.updateDB(id: self.obs.users[self.obs.last-1], status: "reject")
//                    self.obs.updateDB(id: self.obs.users[self.obs.last], status: "reject")
//                    //after swipe
//                    print("bug testing: after swipe")
//                }
//            }) {
//                    Image("clear").resizable().frame(width: 30, height: 30).padding()}
//                    .foregroundColor(.pink)
//                    .background(Color.white)
//                    .shadow(radius: 25)
//                    .clipShape(Circle())
                Button(action:{
    
                }) {
                    Image("pointing-left").resizable().frame(width: 50, height: 50).padding(.bottom)}
                        .foregroundColor(.red)
                        //.background(Color.white)
                        //.shadow(radius: 25)
                        //.clipShape(Circle())
            Spacer()
//            Button(action:{
//
//            }) {
//                    Image("star").resizable().frame(width: 25, height: 25).padding()}
//                    .foregroundColor(.blue)
//                    .background(Color.white)
//                    .shadow(radius: 25)
//                    .clipShape(Circle())

            
            // Heart button commented out for now
//            Button(action:{
//                if self.obs.last == -1 {
//                    //self.obs.updateDB(id: self.obs.users[self.obs.users.count-1], status: "liked")
//                    self.obs.updateDB(id: self.obs.users[self.obs.users.count-1], status: "liked")
//                    //before swipe
//                    print("bug testing: before swipe")
//                }
//                else {
//                    //self.obs.updateDB(id: self.obs.users[self.obs.last-1], status: "liked")
//                    self.obs.updateDB(id: self.obs.users[self.obs.last], status: "liked")
//                    //after swipe
//                    print("bug testing: after swipe")
//                }
//            }) {
//                    Image("heart").resizable().frame(width: 35, height: 35).padding()}
//                    .foregroundColor(.blue)
//                    .background(Color.white)
//                    .shadow(radius: 25)
//                    .clipShape(Circle())
            
            Button(action:{

                }) {
                    Image("pointing-right").resizable().frame(width: 50, height: 50).padding(.bottom)}
                        .foregroundColor(.green)
                        //.background(Color.white)
                        //.shadow(radius: 25)
                        //.clipShape(Circle())
            Spacer()
//            Button(action:{
//
//            }) {
//                    Image("current").resizable().frame(width: 25, height: 25).padding()}
//                    .foregroundColor(.purple)
//                    .background(Color.white)
//                    .shadow(radius: 25)
//                    .clipShape(Circle())
        }
    }
}

struct SwipeMatchView : View{
    @EnvironmentObject var obser : observer
    let uid = userID()
    var body : some View {
        
        GeometryReader{geo in
            ZStack{
                ForEach(self.obser.users) {i in
                    SwipeDetailsView(name: i.name, age: i.age, image: i.image, height: geo.size.height - 100).gesture(DragGesture()
                        
                        .onChanged({ (value) in
                            if value.translation.width > 0 {
                                self.obser.update(id: i, value: value.translation.width, degree: 8)
                            }
                            else{
                                self.obser.update(id: i, value: value.translation.width, degree: -8)
                            }
                        }).onEnded({ (value) in
                            if i.swipe > 0{
                                if i.swipe > geo.size.width / 2 - 80 {
                                    //liked
                                    self.obser.update(id: i, value: 500, degree: 0)
                                    self.obser.updateDB(id: i, status: "liked", swiperUID: self.uid, swipedOnUID: i.uid)
                                    print(self.uid)
                                }
                                else{
                                    self.obser.update(id: i, value: 0, degree: 0)
                                }
                            }
                            else{
                                if -i.swipe > geo.size.width / 2 - 80 {
                                    //reject
                                    self.obser.update(id: i, value: -500, degree: 0)
                                    self.obser.updateDB(id: i, status: "rejected", swiperUID: self.uid, swipedOnUID: i.uid)
                                    print(self.uid)
                                }
                                else{
                                    self.obser.update(id: i, value: 0, degree: 0)
                                }
                            }
                        })
                    ).offset(x: i.swipe)
                        .rotationEffect(.init(degrees: i.degree))
                        .animation(.spring())
                }
            }
        }
    }
}

struct SwipeDetailsView : View {
    var name = ""
    var age = ""
    var image = ""
    var height : CGFloat = 0
    
    var body : some View {
        GeometryReader{ geo in
            ZStack{
                AnimatedImage(url: URL(string: self.image)!).resizable().aspectRatio(contentMode: .fill).frame(width: geo.size.width / 1.12, height: geo.size.height / 1.2, alignment: .center).cornerRadius(15).padding(.horizontal, 15)
                //AnimatedImage(url: URL(string: self.image)!).resizable().aspectRatio(contentMode: .fill).frame(width: geo.size.width / 1.15, height: geo.size.height / 1.1, alignment: .center).cornerRadius(20).padding(.horizontal, 15)
                VStack{
                    Spacer()
                    HStack{
                        VStack(alignment: .leading, content: {
                            Text(self.name).font(.system(size: 25)).fontWeight(.heavy).foregroundColor(.white)
                            Text(self.age).foregroundColor(.white)
                        })
                        Spacer()
                    }
                }.padding([.bottom, .leading], 35)
            }.frame(height: self.height)
        }
    }
}

struct Loader : UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<Loader>) -> Loader.UIViewType {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.startAnimating()
        return indicator
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<Loader>) {
        
    }
}

class observer : ObservableObject{
    @Published var users = [datatype]()
    @Published var last = -1
    init () {
        let db = Firestore.firestore()
        //db.collection("users").getDocuments { (snap, err) in
        db.collection("users2").getDocuments { (snap, err) in
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            
            for i in snap!.documents {
                let name = i.get("name") as! String
                let age = "\(i.get("age"))"
                //let image = i.get("image") as! String
                var image = i.get("imageUrl1") as! String
                if image == "" {
                    image = "https://firebasestorage.googleapis.com/v0/b/cpsc575project.appspot.com/o/Profile%20Images%2Fuser-2517430.png?alt=media&token=c42c47e5-b0b2-4633-a098-156ad87f2407"
                }
                let id = i.documentID
                //let id = i.get("uid") as! String
                let status = i.get("status") as! String
                let liked = i.get("liked") as! [String]
                let rejected = i.get("rejected") as! [String]
                let uid = i.get("uid") as! String
                if !liked.contains(userID()) && !rejected.contains(userID()) && userID() != uid {
                    self.users.append(datatype(id: id, name: name, image: image, age: age, swipe: 0, degree: 0, uid: uid))
                }
            }
        }
    }
    
    func update(id : datatype, value : CGFloat, degree: Double){
        for i in 0..<self.users.count{
            if self.users[i].id == id.id{
                self.users[i].swipe = value
                self.users[i].degree = degree
                self.last = i
            }
        }
    }
    
    
    func updateDB(id : datatype, status : String, swiperUID: String, swipedOnUID: String) {
        let db = Firestore.firestore()
        
        if status == "liked" {
            db.collection("chats").addDocument(data: [
                "users":[swiperUID,swipedOnUID]
            ])
        }
        
        db.collection("users2").document(id.id).updateData([status: FieldValue.arrayUnion([swiperUID])])
        db.collection("users2").document(id.id).updateData(["status":status]) { (err) in
        
            if err != nil{
                print(err)
                return
            }
            print("success")
            
            for i in 0..<self.users.count{
                if self.users[i].id == id.id {
                    if status == "liked" {
                        self.users[i].swipe = 500
                    }
                    else if status == "rejected" {
                        self.users[i].swipe = -500
                    }
                    else{
                        self.users[i].swipe = 0
                    }
                }
            }
        }
    }
    
    func goBack(index : Int){
        self.users[index].swipe = 0
    }
}


struct datatype : Identifiable {
    var id : String
    var name : String
    var image : String
    var age : String
    var swipe : CGFloat
    var degree : Double
    var uid : String
}
