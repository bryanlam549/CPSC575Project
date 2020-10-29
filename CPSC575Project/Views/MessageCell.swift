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
    var body: some View {
        HStack {
            Image("maleMock3")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100, alignment: .center)
                .cornerRadius(50)
            
            VStack(alignment: .leading) {
                Text("Jordan Test")
                    .fontWeight(.bold)
                    .padding(.bottom, 10)
                Text("Hi! Would you like to go on hike at this...")
            }.padding(10)
        }
    }
}

struct MessagesCell_Previews: PreviewProvider {
    static var previews: some View {
        MessagesCell()
    }
}
