//
//  VMMessage.swift
//  CPSC575Project
//
//  Created by bryan lam on 2020-11-16.
//  Copyright © 2020 bryan lam. All rights reserved.
//

import Foundation
import Combine

class VMMessage: ObservableObject{
    @Published var userRepository = UserRepository()
    @Published var messageCellModels = [MessagesCellModel]()
    private var cancellables = Set<AnyCancellable>()
    

}
