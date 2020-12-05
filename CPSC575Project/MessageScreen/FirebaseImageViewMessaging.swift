//
//  FirebaseImageView.swift
//  CPSC575Project
//
//  Created by Cody Tang  on 2020-11-22.
//  Copyright © 2020 bryan lam. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import FirebaseStorage

struct FirebaseImageViewMessage: View {
    @ObservedObject var imageLoader:DataLoader
    @State var image:UIImage = UIImage()
    
    init(imageURL: String) {
        imageLoader = DataLoader(urlString:imageURL)
    }

    var body: some View {
            VStack {
                Image(uiImage: self.image)
                .resizable()
                .renderingMode(.original)
            }.onReceive(self.imageLoader.didChange) { data in
                if UIImage(data: data) != nil {
                    downloadedProfileImage = true
                }
                self.image = UIImage(data: data) ?? UIImage()
            }
        
    }
}



