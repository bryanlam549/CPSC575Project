//
//  TopView.swift
//  CPSC575Project
//
//  Created by Selma Novl on 2020-10-28.
//  Copyright © 2020 bryan lam. All rights reserved.
//

import Foundation
import SwiftUI

struct TopView: View {
    var body: some View {
        
        ZStack {
            TopTitle()
            
            HStack {
                Spacer()
                
                Button(action: settingButtonTapped) {
                    Image(systemName: "gearshape.fill")
                        .foregroundColor(.black)
                }.padding(.trailing)
            }
        }
    }
    
    func settingButtonTapped() {
        print("Settings button tapped.")
    }
}

struct TopView_Previews: PreviewProvider {
    static var previews: some View {
        TopView()
    }
}
