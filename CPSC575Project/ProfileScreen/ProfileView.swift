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
                VStack{
                    //TopView().padding(.bottom)
                    ZStack{
                        Image("profile").resizable().edgesIgnoringSafeArea(.all).blur(radius: 80)
                                        GeometryReader { geo in
                                                    
                                                    VStack {
                                                        TopView().padding(.bottom).offset(y: -10)
                                                        Spacer()//.frame(height: 30)
                                                        Text("Profile")
                                                            .font(.title)
                                                            .fontWeight(.bold)
                                                        //Spacer().frame(height: 20)
                                                        ZStack {
                                                            Image("profile")
                                                                .resizable()
                                                                .frame(width: geo.size.width / 1.5, height: geo.size.width / 1.5, alignment: .center)
                                                                .cornerRadius((geo.size.width / 1.5) / 2)
                                                            
                                                            VStack {
                                                                Spacer()
                                                                HStack {
                                                                    Spacer()
                        //                                            Button(action: self.profileEditButtonTapped) {
                        //                                                Text("Edit")
                        //                                            }
                                                                }
                                                            }
                                                            
                                                        }
                                                        .frame(width: geo.size.width / 1.5, height: geo.size.width / 1.5, alignment: .center)
                                                        .padding(.bottom, 10)
                                                        
                        //                                Text("Jane Doe, 22")
                        //                                    .font(.title)
                        //                                    .fontWeight(.bold)
                        //
                        //                                Text("Business Studnet @ UofC\n\nI love my dogs and staying active:)\n\nContact me ").padding().lineLimit(6)
                        //                                Spacer()
                                                        Spacer()//.frame(height:40)
                                                        
                                                        ZStack(alignment: .top) {
                                                        VStack{
                                                            HStack{
                                                                VStack(alignment: .leading, spacing: 10) {
                                                                    Text("Jane, 22")
                                                                    }
                                                                    .padding(10)
                                                                    //.padding(.top,30)
                                                                    .font(.title)
                                                                Spacer()
                                                                HStack(spacing: 8) {
                                                                    Image("map").resizable().frame(width: 20, height: 20)
                                                                    Text("0 km").font(Font.system(size:18, design: .default))
                                                                }.padding(10)
                                                                .background(Color.black.opacity(0.1))
                                                                .cornerRadius(10)
                                                                }.padding(10)
                                                                .padding(.top, 30)
                                                            Text("Hi, I'm Jane. I'm a business student at the University of Calgary. I love my dogs, travelling and staying active. If we match, feel free to contact me!").padding(10).font(Font.system(size:18, design: .default))
                                                                //Spacer()
                                                        }
                                                        .background(Blurview())
                                                        .clipShape(BottomShape())
                                                        .cornerRadius(25)
                                                        .shadow(radius: 3)
                                                            
                                                        ZStack{
                                                            Button(action: {
                                                                
                                                            }) {
                                                                Image("camera")
                                                                .renderingMode(.original)
                                                                .resizable()
                                                                .frame(width: 35, height: 35)
                                                                .padding(15)
                                                                //.background(Color.black.opacity(0.1))
                                                                .background(Blurview())
                                                                //.background(Color.white)
                                                                .clipShape(Circle())
                                                            }
                                                            
                                                            Circle().stroke(Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)), lineWidth: 5).frame(width: 70, height: 70)
                                                        }.offset(y: -35)
                                                            
                                                        HStack{
                                                            ZStack{
                                                                Button(action: {
                                                                    
                                                                }) {
                                                                    Image("gear")
                                                                        .renderingMode(.original)
                                                                        .resizable()
                                                                        .frame(width: 35, height: 35)
                                                                        .padding(15)
                                                                        .background(Blurview())
                                                                        .clipShape(Circle())
                                                                    }
                                                                Circle().stroke(Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)), lineWidth: 5).frame(width: 70, height: 70)
                                                            }
                                                            Spacer()
                                                            
                                                            ZStack{
                                                                Button(action: {
                                                                    
                                                                }) {
                                                                    Image("edit")
                                                                        .renderingMode(.original)
                                                                        .resizable()
                                                                        .frame(width: 35, height: 35)
                                                                        .padding(15)
                                                                        .background(Blurview())
                                                                        .clipShape(Circle())
                                                                    }
                                                                Circle().stroke(Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)), lineWidth: 5).frame(width: 70, height: 70)
                                                            }
                                                        }.offset(y: -35)
                                                            .padding(.horizontal, 55)
                                                        }
                                    }
                                }.padding(10)
                            }
                                            
                        //                    func profileEditButtonTapped() {
                        //                        print("Profile Edit Button tapped...")
                        //                    }
                        }
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

        struct BottomShape : Shape {
            func path(in rect: CGRect) -> Path {
                return Path{path in
                    path.move(to: CGPoint(x: 0, y: 0))
                    path.addLine(to: CGPoint(x: 0, y: rect.height))
                    path.addLine(to:CGPoint(x: rect.width, y: rect.height))
                    path.addLine(to: CGPoint(x: rect.width, y:0))
                    path.addArc(center: CGPoint(x: rect.width / 2, y: 0), radius: 35, startAngle: .zero, endAngle:  .init(degrees: 180), clockwise: false)
                }
            }
        }

        struct Blurview : UIViewRepresentable {
            func makeUIView(context: UIViewRepresentableContext<Blurview>) ->
                UIVisualEffectView {
                    let view = UIVisualEffectView(effect: UIBlurEffect(style:
                        .systemUltraThinMaterialLight))
                    return view
            }
            
            func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Blurview>) {
                
            }
        }
