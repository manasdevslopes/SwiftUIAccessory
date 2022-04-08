//
//  TodayItem.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 08/04/22.
//

import Foundation

struct TodayItem: Identifiable {
    var id = UUID().uuidString
    var title: String
    var category: String
    var overlay: String
    var contentImage: String
    var logo: String
}

var items: [TodayItem] = [
    TodayItem(title: "Forza Street", category: "Ultimate Street Racing Game", overlay: "GAME OF THE DAY", contentImage: "manas_iosdev", logo: "Manas4"),
    TodayItem(title: "Roblox", category: "Adventure", overlay: "APP OF THE DAY", contentImage: "Manas3", logo: "Manas4")
]
