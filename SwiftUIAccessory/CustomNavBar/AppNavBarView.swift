//
//  AppNavBarView.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 23/03/22.
//

import SwiftUI

struct AppNavBarView: View {
    var body: some View {
        CustomNavView {
            ZStack {
                Color.orange.ignoresSafeArea()
                
                CustomNavLink(
                    destination:
                                Text("Destination")
                                    .customNavigationTitle("Second Screen")
                                    .customNavigationSubtitle("Subtitle here")
                ) {
                    Text("Navigate")
                }
            }
            // .customNavigationTitle("Custom Title")
            // .customNavigationBarBackButtonHidden(true)
            .customNavBarItems(title: "Custom Title!", subtitle: nil, backButtonHidden: true)
        }
    }
}

struct AppNavBarView_Previews: PreviewProvider {
    static var previews: some View {
        AppNavBarView()
    }
}

extension AppNavBarView {
    private var defaultNavBarView: some View {
        NavigationView {
            ZStack {
                Color.green.ignoresSafeArea()
                
                NavigationLink(destination:
                                Text("Destination")
                                .navigationTitle("Title 2")
                                .navigationBarBackButtonHidden(false)
                ) {
                    Text("Navigate")
                }
            }
            .navigationBarTitle("Nav Title Here.....")
        }
    }
}
