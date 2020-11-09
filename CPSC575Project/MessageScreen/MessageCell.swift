//
//  MessageCell.swift
//  CPSC575Project
//
//  Created by Selma Novl on 2020-10-29.
//  Copyright © 2020 bryan lam. All rights reserved.
//

import Foundation
import SwiftUI

struct MessagesCell: View {
    var name: String
    var image: String
    var message: String
    var body: some View {
        NavigationLink(destination: Text("test")){
            HStack {
                Image(image)
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100, alignment: .center)
                    .cornerRadius(50)
                
                VStack(alignment: .leading) {
                    Text(name)
                        .fontWeight(.bold)
                        .padding(.bottom, 10)
                    Text(message)
                }.padding(10)
            }
        }
    }
}

struct MessagesCell_Previews: PreviewProvider {
    static var previews: some View {
        MessagesCell(name: "Jordan Test", image: "maleMock3", message: "Hi! Would you like to go on hike at this...")
    }
}
