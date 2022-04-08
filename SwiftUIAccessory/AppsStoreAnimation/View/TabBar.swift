//
//  TabBar.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 08/04/22.
//

import SwiftUI

struct TabBar: View {
    @Namespace var todayAnimation
    
    @StateObject var detailsViewsModel = DetailsViewsModel()
    
    var body: some View {
        ZStack {
            TabView {
                Today(todayAnimation: todayAnimation)
                    .environmentObject(detailsViewsModel)
                    .tabItem {
                        Image(systemName: "doc.text.image.fill")
                            .renderingMode(.template)
                        Text("Today")
                    }
                Text("Games")
                    .tabItem {
                        Image(systemName: "dpad.fill")
                            .renderingMode(.template)
                        Text("Games")
                    }
                Text("Apps")
                    .tabItem {
                        Image(systemName: "square.stack.3d.up.fill")
                            .renderingMode(.template)
                        Text("Apps")
                    }
                Text("Arcade")
                    .tabItem {
                        Image(systemName: "gamecontroller.fill")
                            .renderingMode(.template)
                        Text("Arcade")
                    }
                Text("Search")
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                            .renderingMode(.template)
                        Text("Search")
                    }
            }
            
            // hiding tab bar when details view opens
            .opacity(detailsViewsModel.show ? 0 : 1)
            
             
            if detailsViewsModel.show {
                DetailsViews(detail: detailsViewsModel, todayAnimation: todayAnimation)
            }
        }
    }
}
