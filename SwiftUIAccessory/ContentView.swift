//
//  ContentView.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 14/12/21.
//

import SwiftUI

struct ContentView: View {
    @State var endAnimation: Bool = false
    
    let userSignedIn: Bool
    var body: some View {
        // UITestingView(currentUserSignedIn: userSignedIn)
        ZStack {
            // SplashScreenHomeView()
            LampUIScreen()
                .offset(y: endAnimation ? 0 : getRect().height)
            
            SplashScreen(endAnimation: $endAnimation)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(userSignedIn: true)
    }
}
