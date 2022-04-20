//
//  ProfileCardSwiftUI.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 20/04/22.
//

import SwiftUI

struct ProfileCardSwiftUI: View {
    var body: some View {
        ZStack {
            ProfileCardFinalView()
        }
    }
}

extension Color{
    static let darkStart = Color("darkStart")
    static let darkEnd = Color("darkEnd")
}

struct ProfileCardFinalView: View {
    var body: some View {
        ZStack {
            BaseCard()
            SideButton()
        }
    }
}

struct BaseCard: View {
    var body: some View {
        ZStack {
            Color("darkStart").opacity(1).ignoresSafeArea()
            
            RoundedRectangle(cornerRadius: 35)
                .foregroundColor(.darkStart)
                .frame(width: 300, height: 300, alignment: .center)
                .shadow(color: Color.darkStart, radius: 10, x: 5, y: 5)
                .shadow(color: Color.darkEnd, radius: 10, x: -5, y: -5)
            
            VStack{
                Image("manas_iosdev")
                    .resizable()
                    .frame(width: 120, height: 120, alignment: .center)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                
                Text("Manas Vijaywargiya")
                    .font(.title)
                    .fontWeight(.regular)
                    .foregroundColor(Color.white)
                
                Text("Apple  Developer")
                    .font(.title3)
                    .fontWeight(.thin)
                    .foregroundColor(Color.white)
            }
        }
    }
}

struct ProfileCardSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCardSwiftUI()
    }
}

struct SideButton: View {
    @State private var buttonToggle = false
    
    var body: some View {
        ZStack {
            if buttonToggle {
                SkillCardView()
            }
            
            Button(action: {
                self.buttonToggle.toggle()
            }) {
                ZStack{
                    Rectangle()
                        .clipShape(CustomShape(
                            corner: [.bottomRight,.topLeft], radii: 35
                        ))
                        .frame(width: 65, height: 65, alignment: .center)
                        .foregroundColor(.white)
                        .shadow(radius: 7)
                    ZStack{
                        Image(systemName: "arrow.right")
                            .resizable()
                            .foregroundColor(Color("darkStart"))
                            .frame(width: 35, height: 20, alignment: .center)
                            .rotationEffect(.degrees(buttonToggle ? 220 : 40))
                            .animation(Animation.easeInOut(duration: 1).repeatCount(1), value: buttonToggle)
                    }
                }
            }
            .offset(x: 120, y: 120)
            
            Rectangle()
                .clipShape(CustomShape(
                    corner: [.bottomRight,.topLeft], radii: 35
                ))
                .frame(width: 70, height: 70, alignment: .center)
                .offset(x: -235.8, y: -235.8)
                .foregroundColor(Color("darkEnd"))
                .offset(x: 120, y: 120)
        }
    }
}
