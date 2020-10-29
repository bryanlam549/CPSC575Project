//
//  ListTitleView.swift
//  CPSC575Project
//
//  Created by Selma Novl on 2020-10-29.
//  Copyright © 2020 bryan lam. All rights reserved.
//

import Foundation
import SwiftUI

struct ListTitleView: View {
    let title: String
    var body: some View {
        HStack {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.leading)
            Spacer()
        }
    }
}

struct ListTitleView_Previews: PreviewProvider {
    static var previews: some View {
        ListTitleView(title: "New")
    }
}
