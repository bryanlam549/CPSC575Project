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

struct FirebaseImageView: View {
    @ObservedObject var imageLoader:DataLoader
    @State var image:UIImage = UIImage()
    
    init(imageURL: String) {
        imageLoader = DataLoader(urlString:imageURL)
    }

    var body: some View {
        GeometryReader { geo in
            VStack {
                Image(uiImage: self.image).resizable()
                .frame(width: geo.size.width / 1.36, height: geo.size.width / 1.36, alignment: .center)
                    .cornerRadius((geo.size.width / 1.36) / 2)
            }.onReceive(self.imageLoader.didChange) { data in
                if UIImage(data: data) != nil {
                    downloadedProfileImage = true
                }
                self.image = UIImage(data: data) ?? UIImage()
            }
        }
    }
}

class DataLoader: ObservableObject {
    @Published var didChange = PassthroughSubject<Data, Never>()
    @Published var data = Data() {
        didSet {
            didChange.send(data)
        }
    }

    init(urlString:String) {
        getDataFromURL(urlString: urlString)
    }
    
    func getDataFromURL(urlString:String) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }.resume()
    }
}

