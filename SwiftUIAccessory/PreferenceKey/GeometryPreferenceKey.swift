//
//  GeometryPreferenceKey.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 22/03/22.
//

import SwiftUI

struct GeometryPreferenceKey: View {
    @State private var rectSize: CGSize = .zero
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("\(rectSize.width)")
            
            Text("Hello, World!")
                .frame(width: rectSize.width, height: rectSize.height)
                .background(Color.blue)
                
            Spacer()
            HStack {
                Rectangle()
                
                GeometryReader {geo in
                    Rectangle()
                        .updateRectangleGeoSize(geo.size)
                        .overlay(
                            Text("\(geo.size.width)")
                                .foregroundColor(.white)
                        )
                }
                Rectangle()
            }
            .frame(height: 55)
        }
        .onPreferenceChange(RectangleGeometrySizePreferenceKey.self) { value in
            self.rectSize = value
        }
    }
}

struct GeometryPreferenceKey_Previews: PreviewProvider {
    static var previews: some View {
        GeometryPreferenceKey()
    }
}

extension View {
    func updateRectangleGeoSize(_ size: CGSize) -> some View {
        preference(key: RectangleGeometrySizePreferenceKey.self, value: size)
    }
}

struct RectangleGeometrySizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}
