//
//  ContentView.swift
//  CPSC575Project
//
//  Created by bryan lam on 2020-09-29.
//  Copyright © 2020 bryan lam. All rights reserved.
//https://www.youtube.com/watch?v=ife5YK-Keng for connecting to firebase w/ logins
//

import SwiftUI
import Firebase

struct ContentView: View {
	//@ObservedObject var model = LoginSignUpModel()
	@EnvironmentObject var model: LoginSignUpModel
	@State private var selection = 0
	
	
	@State var buttClickTest = false
	@State var chatId: String = ""
	@State var msgCellVM: MessageCellVM? = nil
	
	
	var body: some View {
		ZStack{
			if buttClickTest {
				ChatView(senderId: msgCellVM!.uid, chatRowVM: ChatRowVM(senderId: msgCellVM!.uid), buttonPressed: $buttClickTest)
				//ChatView(senderId: msgCellVM!.uid, chatRowVM: ChatRowVM(senderId: msgCellVM!.uid))
			}else{
				if model.logInstatus {
					TabView(selection: $selection){
						ProfileView()
							.font(.title)
							.tabItem {
								VStack {
									Image(systemName: "person.fill")
									Text("Profile")
								}
						}
						.tag(0)
						
						
						
						MatchView()
							.font(.title)
							.tabItem {
								VStack {
									Image(systemName: "heart.fill")
									Text("Heart")
								}
						}
						.tag(1)
						
						
						
						MessageListView(buttonPressed: $buttClickTest, chatId: $chatId, messageCellVM: $msgCellVM)
							.font(.title)
							.tabItem {
								VStack {
									Image(systemName: "message.fill")
									Text("Messages")
								}
						}
						.tag(2)
						
						TestView()
							.font(.title)
							.tabItem {
								VStack {
									Image(systemName: "rectangle.fill")
									Text("Test!!")
								}
						}
						.tag(3)
					}
				}
				else{
					VStack{
						
						Image(systemName: "heart")
							.resizable()
							.frame(width: 200, height: 180)
						
						HStack{
							
							Button(action: {
								self.model.isSignUp = false
							}){
								Text("Existing")
							}
							
							Button(action: {
								self.model.isSignUp = true
							}){
								Text("New")
							}
						}
						if self.model.isSignUp{
							SignUpView()
						}else{
							LoginView()
						}
					}
				}
				
			}
		}
	}
}


//Provides preview screen
/*struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}*/
