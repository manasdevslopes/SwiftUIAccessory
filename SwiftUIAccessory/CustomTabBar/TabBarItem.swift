//
//  TabBarItem.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 22/03/22.
//

import Foundation
import SwiftUI

// Model
//struct TabBarItem: Hashable {
//    let iconName: String
//    let title: String
//    let color: Color
//}

enum TabBarItem: Hashable {
    case home, favorites, profile, messages
    
    var iconName: String {
        switch self {
        case .home: return "house"
        case .favorites: return "heart"
        case .profile: return "person"
        case .messages: return "message"
        }
    }
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .favorites: return "Favorites"
        case .profile: return "Profile"
        case .messages: return "Message"
        }
    }
    
    var color: Color {
        switch self {
        case .home: return Color.red
        case .favorites: return Color.green
        case .profile: return Color.blue
        case .messages: return Color.yellow
        }
    }
}
