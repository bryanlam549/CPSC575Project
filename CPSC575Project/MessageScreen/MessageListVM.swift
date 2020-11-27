//
//  messageCellVM.swift
//  CPSC575Project
//
//  Created by bryan lam on 2020-11-17.
//  Copyright © 2020 bryan lam. All rights reserved.
//

import Foundation
import Combine

class MessageListVM: ObservableObject{
    @Published var userRepository = UserRepository()
    @Published var messageCellVM = [MessageCellVM]()

    private var cancellables = Set<AnyCancellable>()
    
    init(){
        userRepository.$matchedUsers.map { users in
            users.map { user in
                //I need to access chatRepository, use user uid to find most recent message and probably chat timestamp?
                MessageCellVM(user: user)
            }
        }
        .assign(to: \.messageCellVM, on: self)
        .store(in: &cancellables)
    }
}
