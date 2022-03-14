//
//  ViewModifiers.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 14/03/22.
//

import SwiftUI

struct DefaultButtonViewModifier: ViewModifier {
    let backgroundColor: Color
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding()
    }
}

extension View {
    func withDefaultButtonFormatting(backgroundColor: Color = .blue) -> some View {
//        self
//            .modifier(DefaultButtonViewModifier())
        
        // Or, directly without self we can use modifier
        modifier(DefaultButtonViewModifier(backgroundColor: backgroundColor))
    }
}
struct ViewModifiers: View {
    var body: some View {
        VStack {
            Text("Hello, World!")
                .font(.headline)
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(.red)
                .cornerRadius(10)
                .shadow(radius: 10)
                .padding()
            
            Text("Hello, everyone!")
                .modifier(DefaultButtonViewModifier(backgroundColor: .blue))
            
            Text("Hello!")
                .withDefaultButtonFormatting(backgroundColor: .orange)
            
            Text("Hello!")
                .withDefaultButtonFormatting()
        }
    }
}

struct ViewModifiers_Previews: PreviewProvider {
    static var previews: some View {
        ViewModifiers()
    }
}
