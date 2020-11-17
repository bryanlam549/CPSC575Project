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
        userRepository.$users.map { users in
            users.map { user in
                MessageCellVM(messageCell: MessagesCellModel(userId: user.uid!, name: user.name, image: user.imageUrl1, message: "need to somehow grab this"))
            }
        }
        .assign(to: \.messageCellVM, on: self)
        .store(in: &cancellables)
    }
}