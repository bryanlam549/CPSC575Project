//
//  MatchingPersonDetailView.swift
//  CPSC575Project
//
//  Created by Selma Novl on 2020-10-29.
//  Copyright © 2020 bryan lam. All rights reserved.
//

import Foundation
import SwiftUI

struct MatchingPersonDetailView: View {
    var body: some View {
        GeometryReader { geo in
            VStack {
                TopView()
                Image("matchProfile1")
                    .resizable()
                    .padding([.leading, .trailing])
                    .frame(width: geo.size.width, height: geo.size.height / 1.8, alignment: .center)
                
                
                HStack {
                    Text("John Smith (25)")
                    Spacer()
                    Text("5 KM away")
                    
                }
                .padding()
                .font(.headline)
                
                Text("I love my family and hockey. I'm looking for a someone to share my life with")
                    .padding()
                
                HStack(alignment: .bottom) {
                    Spacer()
                  
                    Button(action: self.dislikeButtonTapped) {
                        Image(systemName: "hand.thumbsdown")
                            .font(.largeTitle)
                            .foregroundColor(.red)
                    }
                    Spacer()

                    Button(action: self.likeButtonTapped) {
                        Image(systemName: "hand.thumbsup")
                            .font(.largeTitle)
                            .foregroundColor(.green)
                    }
                    Spacer()
                }.padding()
            }
            Spacer()
            
        }
    }
    
    func likeButtonTapped() {
        
    }
    
    func dislikeButtonTapped() {
        
    }
}

struct MatchingPersonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MatchingPersonDetailView()
            MatchingPersonDetailView()
                .previewDevice("iPhone 11")
        }
    }
}
