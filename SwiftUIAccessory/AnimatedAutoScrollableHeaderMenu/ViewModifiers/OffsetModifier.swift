//
//  OffsetModifier.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 22/12/21.
//

import SwiftUI

struct OffsetModifier: ViewModifier {
    var tab: Tab
    @Binding var currentTab: String
    
    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader{ proxy in
                    Color.clear
                        .preference(key: OffsetKey.self, value: proxy.frame(in: .named("SCROLL")))
                }
            )
            .onPreferenceChange(OffsetKey.self) { proxy in
                print(proxy.minY)
                // if minY is in between 20 to -half of midX
                // then update the currentTab
                let offset = proxy.minY
                
                withAnimation(.easeInOut) {
                    currentTab = (offset < 20 && -offset < (proxy.midX / 2) && currentTab != tab.id) ? "\(tab.id) SCROLL" : currentTab
                }
            }
    }
}

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
