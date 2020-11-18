//
//  messagesCellViewModel.swift
//  CPSC575Project
//
//  Created by bryan lam on 2020-11-17.
//  Copyright © 2020 bryan lam. All rights reserved.
//

import Foundation
import Combine

class MessageCellVM: ObservableObject, Identifiable {
    @Published var userRepository = UserRepository()
    @Published var messageCell: MessagesCellModel
    
    var uid = ""
    var name = ""
    var image = ""
    var message = ""
    private var cancellables = Set<AnyCancellable>()
    
    init(messageCell: MessagesCellModel) {
        self.messageCell = messageCell
        
        //User id
        $messageCell
            .compactMap { messageCell in
                messageCell.userId
        }
        .assign(to: \.uid, on: self)
        .store(in: &cancellables)
        
        //name
        $messageCell
            .compactMap { messageCell in
                messageCell.name
        }
        .assign(to: \.name, on: self)
        .store(in: &cancellables)
        
        //image
        $messageCell
            .compactMap { messageCell in
                messageCell.image
        }
        .assign(to: \.image, on: self)
        .store(in: &cancellables)
        
        //message
        $messageCell
            .compactMap { messageCell in
                messageCell.message
        }
        .assign(to: \.message, on: self)
        .store(in: &cancellables)
        
        //Publish to the database
        //idk what this does... But i don't think we need it? nothing here updates...
        /*$messageCell
            .dropFirst()
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .sink{ task in
                self.taskRepository.updateTask(task)
        }
        .store(in: &cancellables)*/
        
    }
}
