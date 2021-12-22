//
//  AnimatedAutoScrollableHeaderMenu.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 22/12/21.
//

import SwiftUI

struct AnimatedAutoScrollableHeaderMenu: View {
    // Current Tab
    @State var currentTab = ""
    @Namespace var animation
    
    @Environment(\.colorScheme) var colorTab
    
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                HStack(spacing: 15){
                    Button(action: {}) {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                    }
                    Text("McDonald's - Chinatown")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button(action: {}) {
                        Image(systemName: "magnifyingglass")
                            .font(.title2)
                    }
                }
                .foregroundColor(.primary)
                .padding(.horizontal)
                
                ScrollViewReader {proxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 30) {
                            ForEach(tabsItems){tab in
                                VStack {
                                    Text(tab.tab)
                                        .foregroundColor(currentTab.replacingOccurrences(of: " SCROLL", with: "")
                                                         == tab.id ? .black : .gray)
                                    
                                    // For matchedGeometry Effect ....
                                    if currentTab.replacingOccurrences(of: " SCROLL", with: "") == tab.id {
                                        Capsule()
                                            .fill(Color.black)
                                            .matchedGeometryEffect(id: "TAB", in: animation)
                                            .frame(height: 3)
                                            .padding(.horizontal, -10)
                                    } else {
                                        Capsule()
                                            .fill(Color.clear)
                                            .frame(height: 3)
                                            .padding(.horizontal, -10)
                                    }
                                }
                                .onTapGesture {
                                    withAnimation(.easeInOut) {
                                        currentTab = "\(tab.id) TAP"
                                        proxy.scrollTo(currentTab.replacingOccurrences(of: " TAP", with: ""), anchor: .topTrailing)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 30)
                    }
                    .onChange(of: currentTab) { _ in
                        if currentTab.contains(" SCROLL") {
                            withAnimation(.easeInOut) {
                                proxy.scrollTo(currentTab.replacingOccurrences(of: " SCROLL", with: ""), anchor: .topTrailing)
                            }
                        }
                    }
                }
                .padding(.top)
            }
            .padding([.top])
            .background(colorTab == .dark ? Color.black : Color.white)
            .overlay(
                Divider()
                    .padding(.horizontal, -15)
                , alignment: .bottom
            )
            
            ScrollView(.vertical, showsIndicators: false) {
                ScrollViewReader { proxy in
                    VStack(spacing: 15) {
                        ForEach(tabsItems){tab in
                            MenuCardView(tab: tab, currentTab: $currentTab)
                                .padding(.top)
                        }
                    }
                    .padding([.horizontal, .bottom])
                    .onChange(of: currentTab) { newValue in
                        if currentTab.contains(" TAP") {
                            withAnimation(.easeInOut) {
                                proxy.scrollTo(currentTab.replacingOccurrences(of: " TAP", with: ""), anchor: .topTrailing)
                            }
                        }
                    }
                }
            }
            .coordinateSpace(name: "SCROLL")
        }
        // setting first current tab on appear
        .onAppear {
            currentTab = tabsItems.first?.id ?? ""
        }
    }
}

struct MenuCardView: View {
    var tab: Tab
    @Binding var currentTab: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(tab.tab)
                .font(.title.bold())
                .padding(.vertical)
            
            ForEach(tab.foods) {food in
                HStack(spacing: 15) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(food.title)
                            .font(.title3.bold())
                        
                        Text(food.description)
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        Text("Price: \(food.price)")
                            .fontWeight(.bold)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image(food.image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 75, height: 75)
                        .cornerRadius(10)
                    
                }
                
                Divider()
            }
        }
        .modifier(OffsetModifier(tab: tab, currentTab: $currentTab))
        .id(tab.id)
    }
}

struct AnimatedAutoScrollableHeaderMenu_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedAutoScrollableHeaderMenu()
    }
}
