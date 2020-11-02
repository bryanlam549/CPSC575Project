//
//  TopTitle.swift
//  CPSC575Project
//
//  Created by Selma Novl on 2020-10-28.
//  Copyright © 2020 bryan lam. All rights reserved.
//

import Foundation
import SwiftUI

struct TopTitle: View {
    var body: some View {
        Text("SoberSurfing")
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)))
    }
}

struct TopTitle_Previews: PreviewProvider {
    static var previews: some View {
        TopTitle()
    }
}
