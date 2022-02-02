//
//  HapticsVibrations.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 02/02/22.
//

import SwiftUI

class HapticManager {
    static let instance = HapticManager() // Singleton
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
struct HapticsVibrations: View {
    var body: some View {
        VStack(spacing: 20) {
            Button("Success Haptics") { HapticManager.instance.notification(type: .success) }
            Button("Error Haptics") { HapticManager.instance.notification(type: .error) }
            Button("Warning Haptics") { HapticManager.instance.notification(type: .warning) }
            
            Divider()
            
            Button("Heavy Impact") { HapticManager.instance.impact(style: .heavy) }
            Button("Light Impact") { HapticManager.instance.impact(style: .light) }
            Button("Medium Impact") { HapticManager.instance.impact(style: .medium) }
            Button("Rigid Impact") { HapticManager.instance.impact(style: .rigid) }
            Button("Soft Impact") { HapticManager.instance.impact(style: .soft) }
            
        }
    }
}

struct HapticsVibrations_Previews: PreviewProvider {
    static var previews: some View {
        HapticsVibrations()
    }
}
