//
//  ColorPicker.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 07/04/22.
//

import SwiftUI

struct ColorPickers: View {
    @State private var showPicker: Bool = false
    @State var selectedColor: Color = .white
    
    var body: some View {
        ZStack {
            
            Rectangle()
                .fill(selectedColor)
                .ignoresSafeArea()
            
            Button(action: {
                self.showPicker.toggle()
            }) {
                Text("Show Image Color Picker")
                    .foregroundColor(selectedColor.isDarkColor ? .white : .black)
            }
        }
        // MARK: Calling Modifier
        .imageColorPicker(showPicker: $showPicker, color: $selectedColor)
    }
}

struct ColorPickers_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickers()
    }
}
