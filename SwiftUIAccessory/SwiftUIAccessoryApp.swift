//
//  SwiftUIAccessoryApp.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 14/12/21.
//

import SwiftUI

@main
struct SwiftUIAccessoryApp: App {
    let userSignedIn: Bool
    init() {
        // let userIsSignedIn: Bool = CommandLine.arguments.contains("-UITest_startSignedIn") ? true : false
        // Or,
        let userIsSignedIn: Bool = ProcessInfo.processInfo.arguments.contains("-UITest_startSignedIn") ? true : false
        
        // Or, with environment variable
        // let value = ProcessInfo.processInfo.environment["-UITest_startSignedIn2"]
        // let userIsSignedIn: Bool = value == "true" ? true : false
        
        self.userSignedIn = userIsSignedIn
        print("User is signed In: \(userIsSignedIn)")
    }
    var body: some Scene {
        WindowGroup {
            ContentView(userSignedIn: userSignedIn)
        }
    }
}
