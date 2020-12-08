//
//  ViewRouter.swift
//  CPSC575Project
//
//  Created by Selma Novl on 02/12/20.
//  Copyright © 2020 bryan lam. All rights reserved.
//

import Combine
import SwiftUI

class ViewRouter : ObservableObject {
    
    @Published var currentPage : String = ""
    
    init() {
        if !UserDefaults.standard.bool(forKey: "AlreadyDidTheSurvey") {
            UserDefaults.standard.setValue(true, forKey: "AlreadyDidTheSurvey")
            currentPage = "Survey"
        } else {
            currentPage = "ProfileView"
        }
    }
    
}
