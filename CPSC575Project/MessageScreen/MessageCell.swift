//
//  MessageCell.swift
//  CPSC575Project
//
//  Created by Selma Novl on 2020-10-29.
//  Copyright © 2020 bryan lam. All rights reserved.
//

import Foundation
import SwiftUI

struct MessagesCell: View {
    @ObservedObject var messageCellVM: MessageCellVM
    //var userId: String
    //var name: String
    //var image: String
    //var message: String
    var body: some View {
        Group{
            if (messageCellVM.message == ""){
                NewMatchesCell(name: messageCellVM.name, image: messageCellVM.image)
            }
            else{
                HStack {
                    //I should check if image is in our database or not
                    if(messageCellVM.image == ""){
                        //FirebaseImageView(imageURL: messageCellVM.image)
                        Image("profile")
                            .resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100, alignment: .center)
                            .cornerRadius(50)
                    }else{
                        FirebaseImageViewMessage(imageURL: messageCellVM.image)
                            //.resizable()
                            //.renderingMode(.original)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100, alignment: .center)
                            .cornerRadius(50)
                    }
                    
                    
                    VStack(alignment: .leading) {
                        Text(messageCellVM.name)
                            .fontWeight(.bold)
                            .padding(.bottom, 10)
                        Text(messageCellVM.message)
                            .frame(minHeight: 50, maxHeight: 100, alignment: .topTrailing)
                            .truncationMode(.tail)
                    }.padding(10)
                }
            }
        }
        
    }
}

/*struct MessagesCell_Previews: PreviewProvider {
 static var previews: some View {
 MessagesCell(userId: "1", name: "Jordan Test", image: "maleMock3", message: "Hi! Would you like to go on hike at this...")
 }
 }*/
