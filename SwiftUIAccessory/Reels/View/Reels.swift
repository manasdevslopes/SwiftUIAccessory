//
//  Reels.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 05/02/22.
//

import SwiftUI

struct Reels: View {
    // Hiding tab bar
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    @State var currentTab = "house.fill"
    
    var body: some View {
        // Custom Tab View
        VStack(spacing: 0) {
            TabView(selection: $currentTab) {
                Text("Home")
                    .tag("house.fill")
                
                Text("Search")
                    .tag("magnifyingglass")
                
                ReelsView()
                    .tag("Reels")
                
                Text("Liked")
                    .tag("suit.heart")
                
                Text("Profile")
                    .tag("person.circle")
            }
            
            HStack(spacing: 0) {
                ForEach(["house.fill", "magnifyingglass", "Reels", "suit.heart", "person.circle"], id: \.self) {image in
                    TabBarButton(image: image, isSystemImage: image != "Reels", currentTab: $currentTab)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .overlay(Divider(), alignment: .top)
            // if reels changing color to black...
            .background(currentTab == "Reels" ? .black : .clear)
            
        }
    }
}

struct Reels_Previews: PreviewProvider {
    static var previews: some View {
        Reels()
//            .preferredColorScheme(.dark)
    }
}


// Tab Bar Button....
struct TabBarButton: View {
    var image: String
    var isSystemImage: Bool
    @Binding var currentTab: String
    
    var body: some View {
        Button(action: {
            withAnimation {
                currentTab = image
            }
        }) {
            ZStack {
                if isSystemImage {
                    Image(systemName: image)
                        .font(.title2)
                } else {
                    Image(image)
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                }
            }
            .foregroundColor(currentTab==image ? currentTab == "Reels" ? .white : .primary : .gray)
            .frame(maxWidth: .infinity)
        }
    }
}
