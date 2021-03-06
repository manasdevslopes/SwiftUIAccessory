//
//  BicycleAppSwiftUI.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 19/04/22.
//

import SwiftUI

struct BicycleAppSwiftUI: View {
    var body: some View {
        FinalView()
    }
}

struct BicycleAppSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        BicycleAppSwiftUI()
    }
}


struct FinalView: View {
    
    @State  var login = "Login email"
    @State  var password = "Enter your password"
    
    @State private var birdspeed = false
    
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            
            BicycleView()
                .rotationEffect(.degrees(-35))
                .offset(y: 10)
                .opacity(0.8)
            
            VStack{
                
                    Image("travel")
                        .resizable()
                        .frame(width: 320, height: 300, alignment: .center)
                
                
                Spacer()
                
                VStack{
                    HStack {
                        Image(systemName: "person")
                            .padding()
                        Text(login)
                            .frame(width: 280, height: 50, alignment: .leading)
                    }
                    .foregroundColor(.white)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 1))
                    
                    Spacer()
                        .frame(width: 0, height: 20, alignment: .center)
                    
                    HStack {
                        Image(systemName: "key")
                            .padding()
                        Text(password)
                            .frame(width: 280, height: 50, alignment: .leading)
                    }
                    .foregroundColor(.white)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 1))
                    
                    Text("LOGIN  |  SIGNUP")
                        .foregroundColor(Color.white)
                        .opacity(0.6)
                        .padding()
                }
                
            }
            
        }
    }
}

struct BicycleView: View {
    @State private var rightPedaling = false
    @State private var jumping = false
    @State private var leftPedaling = false
    @State var tyre1  = false
    @State var tyre2 = false
    
    var body: some View {
        ZStack{
            VStack {
                ZStack{
                    VStack{
                        // Bicycle animation
                        HStack {
                            ZStack {
                                ZStack {
                                    Image("leg_l")  // Left Leg
                                        .animation(Animation.interpolatingSpring(stiffness: 200, damping: 50).speed(3).repeatForever(autoreverses: true), value: leftPedaling)
                                        .rotationEffect(.degrees(leftPedaling ? -5 : 15), anchor: .topLeading)
                                        .offset(x: -30, y: leftPedaling ? -50 : -65)
                                        .onAppear() {
                                            self.leftPedaling.toggle()
                                        }
                                    Image("biker")  // Biker
                                        .offset(y: -95)
                                    
                                    HStack{
                                        Image(systemName: "line.3.crossed.swirl.circle")  // Tyres
                                            .resizable()
                                            .frame(width : 100, height : 100)
                                            .foregroundColor(Color("BicycleColor")).opacity(1)
                                            .rotationEffect(.degrees(tyre1 ? 180 : 0))
                                            .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: false), value: tyre2)
                                            .onAppear() {
                                                self.tyre2.toggle()
                                            }
                                        
                                        Image(systemName: "line.3.crossed.swirl.circle") // Tyres
                                            .resizable()
                                            .frame(width : 100, height : 100)
                                            .foregroundColor(Color("BicycleColor")).opacity(1)
                                            .rotationEffect(.degrees(tyre2 ? 360 : 0))
                                            .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: false), value: tyre1)
                                            .onAppear() {
                                                self.tyre1.toggle()
                                            }
                                    }
                                    
                                    Image("leg_r") // Right leg
                                        .animation(Animation.interpolatingSpring(stiffness: 200, damping: 50).speed(3).repeatForever(autoreverses: true), value: rightPedaling)
                                        .rotationEffect(.degrees(rightPedaling ? 15 : -15), anchor: .topLeading)
                                        .offset(x: -40, y: rightPedaling ? -45 : -60)
                                        .onAppear() {
                                            self.rightPedaling.toggle()
                                        }
                                }
                                .animation(Animation.interpolatingSpring(stiffness: 200, damping: 50).speed(3).repeatForever(autoreverses: true), value: jumping)
                                .offset(y: jumping ? -1 : 1)
                                .onAppear() {
                                    self.jumping.toggle()
                                }
                            }
                            
                            HStack{
                                Spacer()
                                    .frame(width: 20, alignment: .center)
                                
                                VStack{
                                    Text("100")
                                        .font(.largeTitle)
                                        .fontWeight(.heavy)
                                        .foregroundColor(Color.white)
                                    
                                    Text("METERS")
                                        .font(.footnote)
                                        .fontWeight(.heavy)
                                        .foregroundColor(Color.white)
                                }
                            }
                        }
                    }
                }
                Rectangle()
                    .frame(width: 600, height: 5, alignment: .center)
                    .foregroundColor(Color("BicycleColor"))
                    .cornerRadius(25)
            }
        }
    }
}
