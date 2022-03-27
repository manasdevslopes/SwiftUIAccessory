//
//  ContentView.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 14/12/21.
//

import SwiftUI

struct ContentView: View {
    let userSignedIn: Bool
    var body: some View {
        UITestingView(currentUserSignedIn: userSignedIn)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(userSignedIn: true)
    }
}
