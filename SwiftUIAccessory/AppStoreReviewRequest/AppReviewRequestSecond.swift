//
//  AppReviewRequestSecond.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 30/01/22.
//

import SwiftUI

struct AppReviewRequestSecond: View {
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .onAppear {
            AppReviewRequest.requestReviewIfNeeded()
        }
    }
}

struct AppReviewRequestSecond_Previews: PreviewProvider {
    static var previews: some View {
        AppReviewRequestSecond()
    }
}
