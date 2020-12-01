//
//  NewMatchesCell.swift
//  CPSC575Project
//
//  Created by Selma Novl on 2020-10-29.
//  Copyright © 2020 bryan lam. All rights reserved.
//

import Foundation
import SwiftUI

struct NewMatchesCell: View {
    var name: String
    var image: String
    
    var body: some View {
        VStack(alignment: .center) {
            Image(image)
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fill)
                .frame(width: 110, height: 110, alignment: .center)
                .cornerRadius(55)
            Text(name)
                .foregroundColor(.secondary)
                .fontWeight(.bold)
        }
        
    }
}

struct NewMatchesCell_Previews: PreviewProvider {
    static var previews: some View {
        NewMatchesCell(name: "maleMock2", image: "Jerry Robinson")
    }
}
