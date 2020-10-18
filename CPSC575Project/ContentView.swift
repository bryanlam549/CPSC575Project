//
//  ContentView.swift
//  CPSC575Project
//
//  Created by bryan lam on 2020-09-29.
//  Copyright © 2020 bryan lam. All rights reserved.
//
//

import SwiftUI

struct ContentView: View {

	
	
	@State private var selection = 0
	var body: some View {
		TabView(selection: $selection){
			ProfileView()
				.font(.title)
				.tabItem {
					VStack {
						Image(systemName: "circle")
						Text("Profile")
					}
			}
			.tag(0)
			
			
			
			MatchView()
				.font(.title)
				.tabItem {
					VStack {
						Image(systemName: "heart")
						Text("Heart")
					}
			}
			.tag(1)
			
			
			
			MessageView()
				.font(.title)
				.tabItem {
					VStack {
						Image(systemName: "square")
						Text("Messages")
					}
			}
			.tag(2)
			
			TestView()
				.font(.title)
				.tabItem {
					VStack {
						Image(systemName: "rectangle")
						Text("Test!!")
					}
			}
			.tag(3)
		}
	}
}


//Provides preview screen
struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
