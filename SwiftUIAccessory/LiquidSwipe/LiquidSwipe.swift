//
//  LiquidSwipe.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 12/03/22.
//

import SwiftUI

struct LiquidSwipe: View {
    @State var offset: CGSize = .zero
    @State var showHome: Bool = false
    
    var body: some View {
        ZStack {
            Color("bg")
                .overlay(
                    VStack(alignment: .leading, spacing: 10) {
                        Text("For Gamers")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                        Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
                            .font(.caption)
                            .fontWeight(.bold)
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 30)
                    .offset(x: -15)
                )
                .clipShape(LiquidSwipes(offset: offset))
                .ignoresSafeArea()
                .overlay(
                    Image(systemName: "chevron.left")
                        .font(.largeTitle)
                        .frame(width: 50, height: 50)
                        .contentShape(Rectangle())
                        .gesture(DragGesture().onChanged({ value in
                            withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.6, blendDuration: 0.6)) {
                                offset = value.translation
                            }
                        }).onEnded({ value in
                            let screen = UIScreen.main.bounds
                            
                            withAnimation(.spring()) {
                                if -offset.width > screen.width / 2 {
                                    offset.width = -screen.height
                                    showHome.toggle()
                                } else {
                                    offset = .zero
                                }
                            }
                        }))
                        .offset(x: 15, y: 58)
                        .opacity(offset == .zero ? 1 : 0)
                    , alignment: .topTrailing
                )
                .padding(.trailing)
            
            if showHome {
                Text("Welcome Home!!!!!🤙")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.center)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            offset = .zero
                            showHome.toggle()
                        }
                    }
            }
        }
    }
}

struct LiquidSwipe_Previews: PreviewProvider {
    static var previews: some View {
        LiquidSwipe()
    }
}

struct LiquidSwipes: Shape {
    var offset: CGSize
    var animatableData: CGSize.AnimatableData {
        get { return offset.animatableData }
        set { offset.animatableData = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            let width = rect.width + (-offset.width > 0 ? offset.width : 0)
            // first constructing rectangle shape...
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
            // constructing curve shape...
            // from
            let from = 80 + (offset.width)
            path.move(to: CGPoint(x: rect.width, y: from > 80 ? 80 : from))
            
            var to = 180 + (offset.height) + (-offset.width)
            to = to < 180 ? 180 : to
            
            // mid b/w 80 - 180...
            let mid: CGFloat = 80 + ((to - 80) / 2)

            path.addCurve(to: CGPoint(x: rect.width, y: to), control1: CGPoint(x: width - 50, y: mid), control2: CGPoint(x: width - 50, y: mid))
        }
    }
}
