//
//  MatchedGeometryEffects2.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 21/03/22.
//

import SwiftUI

struct MatchedGeometryEffects2: View {
    let categories: [String] = ["Home", "Popular", "Saved"]
    @State private var selected: String = ""
    @Namespace private var namespace2
    var body: some View {
        HStack {
            ForEach(categories, id: \.self) {category in
                ZStack(alignment: .bottom) {
                    if selected == category {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.red)
                            .matchedGeometryEffect(id: "category_background", in: namespace2)
                            .frame(width: 35, height: 2)
                            .offset(y: 10)
                    }
                    Text(category)
                        .foregroundColor(selected == category ? .red : .black)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .onTapGesture {
                    withAnimation(.spring()) {
                        selected = category
                    }
                }
            }
        }
        .padding()
    }
}

struct MatchedGeometryEffects2_Previews: PreviewProvider {
    static var previews: some View {
        MatchedGeometryEffects2()
    }
}
