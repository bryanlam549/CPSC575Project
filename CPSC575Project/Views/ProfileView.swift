        //
        //  ProfileView.swift
        //  CPSC575Project
        //
        //  Created by bryan lam on 2020-10-18.
        //  Copyright © 2020 bryan lam. All rights reserved.
        //

        import SwiftUI
        import Firebase

        struct ProfileView: View {
            @EnvironmentObject var model: LoginSignUpModel // for testing
            
            var body: some View {
                GeometryReader { geo in
                            
                            VStack {
                                TopView().padding(.bottom)
                                Text("Profile")
                                    .font(.title)
                                    .fontWeight(.bold)
                                
                                ZStack {
                                    Image("profile")
                                        .resizable()
                                        .frame(width: geo.size.width / 1.5, height: geo.size.width / 1.5, alignment: .center)
                                        .cornerRadius((geo.size.width / 1.5) / 2)
                                    
                                    VStack {
                                        Spacer()
                                        HStack {
                                            Spacer()
                                            Button(action: self.profileEditButtonTapped) {
                                                Text("Edit")
                                            }
                                        }
                                    }
                                    
                                }.frame(width: geo.size.width / 1.5, height: geo.size.width / 1.5, alignment: .center)
                                
                                Text("Jane Doe, 22")
                                    .font(.title)
                                    .fontWeight(.bold)
                                
                                Text("Business Studnet @ UofC\n\nI love my dogs and staying active:)\n\nContact me ").padding().lineLimit(6)
                                Spacer()
                            }
                        }
                    }
                    
                    func profileEditButtonTapped() {
                        print("Profile Edit Button tapped...")
                    }
                }

                struct ProfileView_Previews: PreviewProvider {
                    static var previews: some View {
                        Group {
                            ProfileView()
                            ProfileView()
                                .previewDevice("iPhone 11")
                        }
                    }
                }

