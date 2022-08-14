//
//  DateFormat.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 14/08/22.
//

import SwiftUI

struct DateFormat: View {
    var body: some View {
      Text(Date().displayFormat)
        .font(.largeTitle)
        .padding()
    }
}

struct DateFormat_Previews: PreviewProvider {
    static var previews: some View {
        DateFormat()
    }
}

extension Date {
  var displayFormat: String {
//    self.formatted(date: .numeric, time: .omitted)

//    self.formatted(.dateTime.year(.twoDigits)
//      .month(.wide)
//      .day(.twoDigits)
//      .hour(.conversationalDefaultDigits(amPM: .omitted))
//      .minute(.twoDigits)
//    )

    self.formatted(.iso8601) // ISO Format
    
  }
}
