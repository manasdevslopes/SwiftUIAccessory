//
//  LocalNotifications.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 06/02/22.
//

import SwiftUI
import UserNotifications
import CoreLocation

class NotificationManager {
    // Single instane that we're going to use throughout our entire application so we don't have to keep creating notification managers, we're just going to use this one here
    static let instance = NotificationManager() // singleton
    
    func requestAuthorization() {
        let options:  UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print("Error:😵 \(error.localizedDescription)")
            } else {
                print("Success!👍🏻")
            }
        }
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "This is my first Notification!"
        content.subtitle = "This was so easy!"
        content.sound = .default
        content.badge = 1
        
        // time
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        // calendar
        var dateComponents = DateComponents()
        dateComponents.hour = 17
        dateComponents.minute = 18
        dateComponents.weekday = 1
        let trigger1 = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // location
        let coordinates = CLLocationCoordinate2D(
            latitude: 27.2046,
            longitude: 77.4977)
        let region = CLCircularRegion(
            center: coordinates,
            radius: 100,
            identifier: UUID().uuidString)
        region.notifyOnEntry = true
        region.notifyOnExit = true
        let trigger2 = UNLocationNotificationTrigger(region: region, repeats: true)
        
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger2)
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}

struct LocalNotifications: View {
    var body: some View {
        VStack(spacing: 40) {
            Button(action: {
                NotificationManager.instance.requestAuthorization()
            }) {
                Text("Request Permission")
            }
            
            Button(action: {
                NotificationManager.instance.scheduleNotification()
            }) {
                Text("Schedule Notification")
            }
            
            Button(action: {
                NotificationManager.instance.cancelNotification()
            }) {
                Text("Remove Notification")
            }
        }
        .onAppear {
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    }
}

struct LocalNotifications_Previews: PreviewProvider {
    static var previews: some View {
        LocalNotifications()
    }
}
