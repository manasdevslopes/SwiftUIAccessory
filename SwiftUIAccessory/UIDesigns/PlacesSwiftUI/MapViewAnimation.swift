//
//  MapViewAnimation.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 20/04/22.
//

import SwiftUI

struct MapViewAnimation: View {
    @State private var mapAnimation = false
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25.0)
                .opacity(0.8)
                .frame(width: 700, height: 700, alignment: .center)
                .offset(x: 0, y: -30)
            
            Image("map").resizable().frame(width: 590, height: 635, alignment: .center)
            Image("mapline").resizable().frame(width: 590, height: 635, alignment: .center)
                .opacity(mapAnimation ? 0 : 1)
            Image("pin")
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
                .offset(x: -30 , y: mapAnimation ? -290 :  -300)
        }
        .animation(Animation.easeInOut(duration: 1).repeatForever(), value: mapAnimation)
        .onAppear() {
            self.mapAnimation.toggle()
        }
    }
}

struct MapViewAnimation_Previews: PreviewProvider {
    static var previews: some View {
        MapViewAnimation()
    }
}
