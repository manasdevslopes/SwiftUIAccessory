//
//  SizeClasses.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 14/08/22.
//

import SwiftUI

struct SizeClasses: View {
  @Environment(\.verticalSizeClass) var verticalSizeClass
  @Environment(\.horizontalSizeClass) var horizontalSizeClass
  
  var isLandscape: Bool { verticalSizeClass == .compact }
  
    var body: some View {
      Text(isLandscape ? "I'm Landscape" : "I'm Portrait")
        .font(.largeTitle).bold()
        .foregroundColor(isLandscape ? .red : .blue)
        .padding()
    }
}

struct SizeClasses_Previews: PreviewProvider {
    static var previews: some View {
        SizeClasses()
    }
}
