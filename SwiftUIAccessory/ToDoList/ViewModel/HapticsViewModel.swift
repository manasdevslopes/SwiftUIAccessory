//
//  HapticsViewModel.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 16/04/22.
//

import SwiftUI

class HapticViewModel: ObservableObject {
    func haptic(type: UINotificationFeedbackGenerator.FeedbackType) {
        UINotificationFeedbackGenerator().notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        UIImpactFeedbackGenerator(style: style).impactOccurred()
    }
}
