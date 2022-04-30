//
//  ContentView.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 14/12/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var listVM: ListViewModel = ListViewModel()
    
    @State var endAnimation: Bool = false
    
    let userSignedIn: Bool
    var body: some View {
        // UITestingView(currentUserSignedIn: userSignedIn)
//        ZStack {
//            // SplashScreenHomeView()
//            LampUIScreen()
//                .offset(y: endAnimation ? 0 : getRect().height)
//            SplashScreen(endAnimation: $endAnimation)
//        }
        
//        NavigationView {
//            ListView()
//        }
//        .navigationViewStyle(StackNavigationViewStyle())
//        .environmentObject(listVM)
        
        CompositionalLayout()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(userSignedIn: true)
            .environmentObject(ListViewModel())
    }
}
