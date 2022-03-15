//
//  AnyTransitions.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 15/03/22.
//

import SwiftUI

struct RotateViewModifier: ViewModifier {
    let rotation: Double
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(Angle(degrees: rotation))
            .offset(x: rotation != 0 ? UIScreen.main.bounds.width : 0,
                    y: rotation != 0 ? UIScreen.main.bounds.height : 0)
    }
}

extension AnyTransition {
    // Note: - If we return only one item say AnyTransition. something, we can remove return and it's a extension of AnyTransition so we can also remove AnyTransition. and only start with modifier(active.....)
    static var rotating: AnyTransition {
        return AnyTransition.modifier(active: RotateViewModifier(rotation: 180), identity: RotateViewModifier(rotation: 0))
    }
    
    static func rotating(rotation: Double) -> AnyTransition {
        return AnyTransition.modifier(active: RotateViewModifier(rotation: rotation), identity: RotateViewModifier(rotation: 0))
    }
    
    static var rotateOn: AnyTransition {
        return AnyTransition.asymmetric(insertion: .rotating, removal: .move(edge: .leading))
    }
}

struct AnyTransitions: View {
    @State private var showRectangle: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            
            if showRectangle {
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 250, height: 350)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    //.transition(.move(edge: .leading))
                    // .transition(AnyTransition.scale.animation(.easeInOut))
                    // .transition(AnyTransition.rotating.animation(.easeInOut))
                    // .transition(.rotating.animation(.easeInOut))
                    // .transition(.rotating(rotation: 1080))
                    .transition(.rotateOn)
            }
            
            Spacer()
            
            Text("Click me!")
                .withDefaultButtonFormatting()
                .padding(.horizontal, 40)
                .onTapGesture {
                    // withAnimation(.easeInOut(duration: 5.0)) {
                       // showRectangle.toggle()
                    // }
                    withAnimation(.easeInOut) {
                        showRectangle.toggle()
                    }
                }
        }
    }
}

struct AnyTransitions_Previews: PreviewProvider {
    static var previews: some View {
        AnyTransitions()
    }
}
