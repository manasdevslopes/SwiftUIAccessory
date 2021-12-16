//
//  EnvironmentValues.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 16/12/21.
//

import SwiftUI

struct EnvironmentValues: View {
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        if dynamicTypeSize >= .accessibility2 {
            VStack {
                Image("Manas")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                
                Text("Manas Vijaywargiya")
                    .bold()
                    .font(.title)
                    .foregroundColor(colorScheme == .dark ? .red : .green)
            }
        } else {
            HStack {
                Image("Manas")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                
                Text("Manas Vijaywargiya")
                    .bold()
                    .font(.title)
                    .foregroundColor(colorScheme == .dark ? .red : .green)
            }
        }
        
    }
}

struct EnvironmentValues_Previews: PreviewProvider {
    static var previews: some View {
        EnvironmentValues()
            .preferredColorScheme(.dark)
            .environment(\.dynamicTypeSize, .accessibility1)
    }
}
