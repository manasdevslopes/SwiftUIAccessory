//
//  PreferenceKeyBootcamp.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 22/03/22.
//

import SwiftUI

struct PreferenceKeyBootcamp: View {
    @State private var text: String = "Hello, World!"
    var body: some View {
        NavigationView {
            VStack {
                SecondaryScreen(text: text)
                    .navigationTitle("Navigation Title")
                    //.customTitle("NEW VALUE!!!!!")
                    // .preference(key: CustomTitlePreferenceKey.self, value: "NEW VALUE")
            }
            .onPreferenceChange(CustomTitlePreferenceKey.self) { value in
                self.text = value
            }
        }
    }
}

extension View {
    func customTitle(_ text: String) -> some View {
        // Or, remove "self." from here as we are creating extension of View so no need
        // self.
        preference(key: CustomTitlePreferenceKey.self, value: text)
    }
}

struct PreferenceKeyBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceKeyBootcamp()
    }
}

struct SecondaryScreen: View {
    let text: String
    @State private var newValue: String = ""
    
    var body: some View {
        Text(text)
            .onAppear { getDataFromDataBase() }
            // .preference(key: CustomTitlePreferenceKey.self, value: "NEW VALUE")
            .customTitle(newValue)
        
    }
    func getDataFromDataBase() {
        // download
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.newValue = "New Value From Database!!!!!"
        }
    }
}

// PreferenceKey -> passing value from child view to parent view
struct CustomTitlePreferenceKey: PreferenceKey {
    static var defaultValue: String = ""
    
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}
