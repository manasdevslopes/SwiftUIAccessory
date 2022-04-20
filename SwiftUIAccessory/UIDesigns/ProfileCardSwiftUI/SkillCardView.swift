//
//  SkillCardView.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 20/04/22.
//

import SwiftUI

struct SkillCardView: View {
    @State var shapechange = false
    
    @State private var skillsopac = false
    @State private var androidopac = false
    @State private var iosopac = false
    @State private var unityopac = false
    
    @State private var facebooksh = false
    @State private var instagramsh = false
    @State private var linkedinsh = false
    
    var body: some View {
        ZStack{
            //Background Shape
            Rectangle()
                .clipShape(CustomShape(
                    corner: [.bottomRight,.topLeft,.bottomLeft,.topRight], radii: shapechange ? 15 : 35
                ))
                .foregroundColor(Color("darkEnd"))
                .frame(width: shapechange ? 300 : 65, height: shapechange ? 300 : 65, alignment: .center)
                .offset(x: shapechange ? 0 : -120, y: shapechange ? 0 : -120)
                .animation(Animation.easeInOut(duration: 1).repeatCount(1), value: shapechange)
                .onAppear {
                    shapechange.toggle()
                }
            
            VStack{
                HStack {
                    //Skill Opacity
                    Text("Skills")
                        .font(.title)
                        .fontWeight(.medium)
                        .foregroundColor(Color.white)
                        .scaleEffect(skillsopac ? 1 : 0)
                        .animation(Animation.easeInOut(duration: 1).delay(0.2).repeatCount(1), value: skillsopac)
                        .onAppear {
                            skillsopac.toggle()
                        }
                    Spacer().frame(width: 180, height: 0, alignment: .center)
                }
                Spacer().frame(width: 0, height: 20, alignment: .center)
                //Skills
                HStack {
                    // Android Opacity
                    ZStack{
                        Rectangle()
                            .frame(width: 85, height: 30, alignment: .center)
                            .foregroundColor(.clear)
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.white, lineWidth: 2))
                        Text("Android")
                            .foregroundColor(.white)
                    }
                    .scaleEffect(androidopac ? 1 : 0)
                    .animation(Animation.easeInOut(duration: 1).delay(0.2).repeatCount(1), value: androidopac)
                    .onAppear {
                        androidopac.toggle()
                    }
                    
                    ZStack{
                        Rectangle()
                            .frame(width: 45, height: 30, alignment: .center)
                            .foregroundColor(.clear)
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.white, lineWidth: 2))
                        Text("IOS")
                            .foregroundColor(.white)
                    }
                    .scaleEffect(iosopac ? 1 : 0)
                    .animation(Animation.easeInOut(duration: 1).delay(0.3).repeatCount(1), value: iosopac)
                    .onAppear {
                        iosopac.toggle()
                    }
                    
                    ZStack{
                        Rectangle()
                            .frame(width: 75, height: 30, alignment: .center)
                            .foregroundColor(.clear)
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.white, lineWidth: 2))
                        Text("Unity3D")
                            .foregroundColor(.white)
                    }
                    .scaleEffect(unityopac ? 1 : 0)
                    .animation(Animation.easeInOut(duration: 1).delay(0.3).repeatCount(1), value: unityopac)
                    .onAppear {
                        unityopac.toggle()
                    }
                }.padding()
                
                HStack{
                    Image("facebook")
                        .resizable()
                        .frame(width: 35, height: 35, alignment: .center)
                        .scaleEffect(facebooksh ? 1 : 0)
                        .animation(Animation.easeInOut(duration: 1).delay(0.6).repeatCount(1), value: facebooksh)
                        .onAppear {
                            facebooksh.toggle()
                        }
                    Image("insta")
                        .resizable()
                        .frame(width: 35, height: 35, alignment: .center)
                        .scaleEffect(instagramsh ? 1 : 0)
                        .animation(Animation.easeInOut(duration: 1).delay(0.6).repeatCount(1), value: instagramsh)
                        .onAppear {
                            instagramsh.toggle()
                        }
                    
                    Image("linked")
                        .resizable()
                        .frame(width: 35, height: 35, alignment: .center)
                        .scaleEffect(linkedinsh ? 1 : 0)
                        .animation(Animation.easeInOut(duration: 1).delay(0.7).repeatCount(1), value: linkedinsh)
                        .onAppear {
                            linkedinsh.toggle()
                        }
                }
            }
        }
    }
}

struct SkillCardView_Previews: PreviewProvider {
    static var previews: some View {
        SkillCardView()
    }
}
