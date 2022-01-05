//
//  CustomViewTransition.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 05/01/22.
//

import SwiftUI

struct CustomViewTransition: View {
    @State var tapped: Bool = false
    @Namespace var namespace
    
    var body: some View {
        ZStack {
            // From
            if !tapped {
                VStack(alignment: .leading) {
                    Text("SwiftUI")
                        .font(.title.bold())
                        .padding()
                        .matchedGeometryEffect(id: "title", in: namespace)
                    Text("A Video about custom transition")
                        .font(.title2.weight(.medium))
                        .padding()
                        .matchedGeometryEffect(id: "subTitle", in: namespace)
                    Text("Today we will learn how to leverage matched geometry effects.")
                        .font(.footnote.weight(.regular))
                        .padding()
                        .matchedGeometryEffect(id: "description", in: namespace)
                }
                .frame(width: 300, alignment: .leading)
                .background(Color(.systemPink))
                .cornerRadius(20)
                .shadow(color: Color(.secondaryLabel), radius: 12, x: 0, y: 5)
                .matchedGeometryEffect(id: "card", in: namespace)
                
            } else {
                // To
                VStack(alignment: .leading) {
                    Text("SwiftUI")
                        .font(.title.bold())
                        .padding()
                        .matchedGeometryEffect(id: "title", in: namespace)
                    Text("A Video about custom transition")
                        .font(.title2.weight(.medium))
                        .padding()
                        .matchedGeometryEffect(id: "subTitle", in: namespace)
                    Text("Today we will learn how to leverage matched geometry effects.")
                        .font(.footnote.weight(.regular))
                        .padding()
                        .matchedGeometryEffect(id: "description", in: namespace)
                    
                    Spacer()
                }
                .frame(width: 350, alignment: .leading)
                .background(Color(.systemPink))
                .cornerRadius(20)
                .shadow(color: Color(.secondaryLabel), radius: 12, x: 0, y: 5)
                .matchedGeometryEffect(id: "card", in: namespace)
            }
        }
        .onTapGesture {
            withAnimation {
                tapped.toggle()
            }
        }
    }
}

struct CustomViewTransition_Previews: PreviewProvider {
    static var previews: some View {
        CustomViewTransition()
    }
}
