//
//  MatchedGeometryEffects.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 21/03/22.
//

import SwiftUI

struct MatchedGeometryEffects: View {
    @State private var isClicked: Bool = false
    @Namespace private var namespace
    
    var body: some View {
        VStack {
            if !isClicked {
                // RoundedRectangle(cornerRadius: 25)
                Circle()
                    .matchedGeometryEffect(id: "rectangle", in: namespace)
                    .frame(width: 100, height: 100)
            }
            
            Spacer()
            
            if isClicked {
                // RoundedRectangle(cornerRadius: 25)
                Circle()
                    .matchedGeometryEffect(id: "rectangle", in: namespace)
                    .frame(width: 300, height: 200)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.red)
        .onTapGesture {
            withAnimation(.easeInOut) {
                isClicked.toggle()
            }
        }
    }
}

struct MatchedGeometryEffects_Previews: PreviewProvider {
    static var previews: some View {
        MatchedGeometryEffects()
    }
}
