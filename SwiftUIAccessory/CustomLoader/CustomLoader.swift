//
//  CustomLoader.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 14/12/21.
//

import SwiftUI

struct CustomLoader: View {
    var body: some View {
        Loading()
    }
}

struct Loading: View {
    @State var animate = false
    
    var body: some View {
        ZStack {
            Circle().fill(Color.red.opacity(0.25)).frame(width:350, height: 350).scaleEffect(self.animate ? 1 : 0)
            Circle().fill(Color.red.opacity(0.35)).frame(width:250, height: 250).scaleEffect(self.animate ? 1 : 0)
            Circle().fill(Color.red.opacity(0.45)).frame(width:150, height: 150).scaleEffect(self.animate ? 1 : 0)
            Circle().fill(Color.red).frame(width:30, height: 30)
        }
        .onAppear {
            withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: true)) {
                self.animate.toggle()
            }
//            self.animate.toggle()
        }
        .animation(Animation.linear(duration: 1.5).repeatForever(autoreverses: true), value: animate)
//        .animation(Animation.linear(duration: 1.5).repeatForever(autoreverses: true))
    }
}

struct CustomLoader_Previews: PreviewProvider {
    static var previews: some View {
        CustomLoader()
    }
}
