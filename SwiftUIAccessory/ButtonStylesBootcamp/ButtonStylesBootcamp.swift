//
//  ButtonStylesBootcamp.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 14/03/22.
//

import SwiftUI

struct PressableButtonStyle: ButtonStyle {
    let scaledAmount: CGFloat
    
    init(scaledAmount: CGFloat = 0.9) {
        self.scaledAmount = scaledAmount
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scaledAmount : 1.0)
            //.brightness(configuration.isPressed ? 0.05 : 0)
            .opacity(configuration.isPressed ? 0.9 : 1)
    }
}

extension View {
    func withPressableStyle(scaledAmount: CGFloat = 0.9) -> some View {
        // self.buttonStyle(PressableButtonStyle(scaledAmount: scaledAmount))
        // Or,
        buttonStyle(PressableButtonStyle(scaledAmount: scaledAmount))
    }
}
struct ButtonStylesBootcamp: View {
    var body: some View {
        Button(action: {}) {
            Text("Click Me!")
                .withDefaultButtonFormatting()
        }
        // .buttonStyle(PressableButtonStyle())
        // .withPressableStyle(scaledAmount: 0.9)
        .withPressableStyle()
        .padding(40)
    }
}

struct ButtonStylesBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ButtonStylesBootcamp()
    }
}
