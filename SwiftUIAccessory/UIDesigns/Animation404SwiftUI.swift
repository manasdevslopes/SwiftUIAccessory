//
//  Animation404SwiftUI.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 19/04/22.
//

import SwiftUI

//Extension Property
extension Color{
    static let background = Color(red : 08 / 255, green : 51 / 255 , blue : 73 / 255)
}

struct Animation404SwiftUI: View {
    @State var rotateInner = false
    
    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)

            VStack {
                Image("titlename")
                    .resizable()
                    .frame(width: 390, height: 40, alignment: .center)
                
                Spacer()
                    .frame(width: 200, height: 100, alignment: .center)
                
                HStack{
                    ZStack{
                        //Outer Layer
                        Image("layerEarth") // Outer image
                            .resizable()
                            .frame(width : 260 , height: 260)
                            .rotationEffect(.degrees(rotateInner ? -180 : 0))
                            .animation(Animation.easeInOut(duration: 5).repeatForever(autoreverses: true), value: rotateInner)
                        
                        HStack{
                            Image("layer4")
                                .resizable()
                                .frame(width: 100, height: 130, alignment: .center)
                                .shadow(color: .black, radius: 10, x: 0, y: 0)
                            
                            Spacer()
                                .frame(width: 100, height: 100, alignment: .center)
                            
                            Image("layer4")
                                .resizable()
                                .frame(width: 100, height: 130, alignment: .center)
                                .shadow(color: .black, radius: 10, x: 0, y: 0)
                        }
                        
                        //Inner Layer
                        Image("layerrocket") // Outer image
                            .resizable()
                            .frame(width : 300 , height: 300)
                            .rotationEffect(.degrees(rotateInner ? 360 : 0))
                            .animation(Animation.easeInOut(duration: 5).repeatForever(autoreverses: false), value: rotateInner)
                    }
                }
                
                Spacer()
                    .frame(width: 200, height: 200, alignment: .center)
                
                //Home Page Button
                ZStack{
                    RoundedRectangle(cornerRadius: 25.0)
                        .frame(width: 200, height: 60, alignment: .center)
                        .foregroundColor(.background)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25.0)
                                .stroke(Color.white, lineWidth: 1))
                    
                    HStack{
                        Text("GO TO")
                            .font(.headline)
                            .fontWeight(.medium)
                            .foregroundColor(Color.white)
                        
                        Image("home")
                            .resizable()
                            .frame(width: 50, height: 50, alignment: .center)
                        
                        Text("PAGE")
                            .font(.headline)
                            .fontWeight(.medium)
                            .foregroundColor(Color.white)
                    }
                }
            }
        }
        .onAppear() {
            self.rotateInner.toggle()
        }
    }
}

struct Animation404SwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        Animation404SwiftUI()
    }
}
