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
    
    var body: some View {
        
        ZStack{
            Color("LightWhite").edgesIgnoringSafeArea(.all)
            VStack{
                TopMatchView()
                SwipeMatchView()
                BottomMatchView()
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
    var body : some View{
        HStack{
            Button(action:{
                
            }) {
                    Image("reload").resizable().frame(width: 25, height: 25).padding()}
                    .foregroundColor(.yellow)
                    .background(Color.white)
                    .shadow(radius: 25)
                    .clipShape(Circle())
            
            Button(action:{
                
            }) {
                    Image("clear").resizable().frame(width: 30, height: 30).padding()}
                    .foregroundColor(.pink)
                    .background(Color.white)
                    .shadow(radius: 25)
                    .clipShape(Circle())
            
            Button(action:{
                
            }) {
                    Image("star").resizable().frame(width: 25, height: 25).padding()}
                    .foregroundColor(.blue)
                    .background(Color.white)
                    .shadow(radius: 25)
                    .clipShape(Circle())
            
            Button(action:{
                
            }) {
                    Image("heart").resizable().frame(width: 35, height: 35).padding()}
                    .foregroundColor(.blue)
                    .background(Color.white)
                    .shadow(radius: 25)
                    .clipShape(Circle())
            
            Button(action:{
                
            }) {
                    Image("current").resizable().frame(width: 25, height: 25).padding()}
                    .foregroundColor(.purple)
                    .background(Color.white)
                    .shadow(radius: 25)
                    .clipShape(Circle())
        }
    }
}

struct SwipeMatchView : View{
    @ObservedObject var obser = observer()
    var body : some View {
        
        GeometryReader{geo in
            ZStack{
                ForEach(self.obser.users){i in
                    
                    AnimatedImage(url: URL(string: i.image)!).resizable().frame(height: geo.size.height - 100).cornerRadius(20).padding(.horizontal, 15)
                }
            }
        }
    }
}

class observer : ObservableObject{
    @Published var users = [datatype]()
    
    init () {
        let db = Firestore.firestore()
        db.collection("users").getDocuments { (snap, err) in
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            
            for i in snap!.documents {
                let name = i.get("name") as! String
                let age = i.get("age") as! String
                let image = i.get("image") as! String
                let id = i.documentID
                
                self.users.append(datatype(id: id, name: name, image: image, age: age, swipe: 0))
            }
        }
    }
}

struct datatype : Identifiable {
    var id : String
    var name : String
    var image : String
    var age : String
    var swipe : CGFloat
}
