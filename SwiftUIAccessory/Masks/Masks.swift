//
//  Masks.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 21/01/22.
//

import SwiftUI

struct Masks: View {
    @State var rating: Int = 0
    
    var body: some View {
        ZStack {
            VStack {
                Text("Rating: \(rating)")
                starsView
                    .overlay(
                        overlayView
                            .mask(starsView)
                )
            }
        }
    }
    
    private var overlayView: some View {
        GeometryReader{ geo in
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(LinearGradient(colors: [Color.red, Color.blue], startPoint: .leading, endPoint: .trailing))
//                    .foregroundColor(.yellow)
                    .frame(width: CGFloat(rating) / 5 * geo.size.width)
            }
        }
        .allowsHitTesting(false)
    }
    
    private var starsView: some View {
        HStack {
            ForEach(1..<6){index in
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    // .foregroundColor(rating >= index ? .yellow : .gray)
                    .foregroundColor(.gray)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            rating = index
                        }
                    }
            }
        }
    }
}

struct Masks_Previews: PreviewProvider {
    static var previews: some View {
        Masks()
    }
}
