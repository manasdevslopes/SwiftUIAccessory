//
//  AppReviewRequestFirst.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 30/01/22.
//

import SwiftUI

struct AppReviewRequestFirst: View {
    @State private var showSecondView = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: AppReviewRequestSecond(), isActive: $showSecondView) {
                    EmptyView()
                }
                Button(action: {
                    self.showSecondView = true
                }) {
                    Text("Bordered")
                        .frame(maxWidth: .infinity)
                }
                .tint(.green)
                .buttonStyle(.bordered)
                .padding(.horizontal, 50)
            }
            .navigationTitle("App Review Tester")
        }
    }
}

struct AppReviewRequestFirst_Previews: PreviewProvider {
    static var previews: some View {
        AppReviewRequestFirst()
    }
}
