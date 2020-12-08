//
//  MotherView.swift
//  CPSC575Project
//
//  Created by Selma Novl on 02/12/20.
//  Copyright © 2020 bryan lam. All rights reserved.
//

import SwiftUI

struct MotherView: View {
    
    @EnvironmentObject var viewRouter : ViewRouter
    
    var body: some View {
        VStack {
            if viewRouter.currentPage == "Survey"{
            _Survey()
        } else if viewRouter.currentPage == "ProfileView" {
            ProfileView()
        }
    }
  }
}
struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView().environmentObject(ViewRouter())
    }
  }
