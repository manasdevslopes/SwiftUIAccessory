//
//  Context_Menu.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 15/12/21.
//

import SwiftUI

struct Context_Menu: View {
    var body: some View {
        VStack {
            Text("Hello, World!")
                .padding()
                .background(Color.blue.opacity(0.5))
                .clipShape(Capsule())
                .contextMenu {
                    Button(action: {
                        print("Check-in label tapped")
                    }) {
                        Label("Check in", systemImage: "person.fill.checkmark")
                    }
                    
                    Button(action: {
                        print("Call Location")
                    }) {
                        Label("Call Location", systemImage: "phone.fill")
                    }
                    
                    Button(action: {
                        print("Get Directions")
                    }) {
                        Label("Get Directions", systemImage: "location.fill")
                    }
            }
            
            Spacer()
        }
    }
}

struct Context_Menu_Previews: PreviewProvider {
    static var previews: some View {
        Context_Menu()
    }
}
