//
//  RotationGestures.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 18/01/22.
//

import SwiftUI

struct RotationGestures: View {
    @State var angle: Angle = Angle(degrees: 0)
    
    var body: some View {
        Text("Hello, World!")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding(50)
            .background(Color.blue.cornerRadius(10))
            .rotationEffect(angle)
            .gesture(
                RotationGesture()
                    .onChanged {value in
                        angle = value
                    }
                    .onEnded {value in
                        withAnimation(.spring()) {
                            angle = Angle(degrees: 0)
                        }
                    }
            )
    }
}

struct RotationGestures_Previews: PreviewProvider {
    static var previews: some View {
        RotationGestures()
    }
}
