//
//  AppTabBarView.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 22/03/22.
//

import SwiftUI

// Generics
// @ViewBuilder
// PreferenceKey
// MatchedGeometryEffect



struct AppTabBarView: View {
    @State private var selection: String = "home"
    @State private var tabSelection: TabBarItem = .home
    
    var body: some View {
        // defaultTabView
        CustomTabBarContainerView(selection: $tabSelection) {
            Color.red
                .tabBarItem(tab: .home, selection: $tabSelection)
            
            Color.green
                .tabBarItem(tab: .favorites, selection: $tabSelection)
            
            Color.blue
                .tabBarItem(tab: .profile, selection: $tabSelection)
            
            Color.yellow
                .tabBarItem(tab: .messages, selection: $tabSelection)
        }
    }
}

struct AppTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabBarView()
    }
}

extension AppTabBarView {
    private var defaultTabView: some View {
        TabView(selection: $selection) {
            Color.red
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            Color.green
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favorites")
                }
            Color.blue
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
    }
}
