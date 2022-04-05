//
//  LocalizationBootcamp.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 05/04/22.
//

import SwiftUI

struct LocalizationBootcamp: View {
    var body: some View {
        NavigationView {
            Form {
                TextField(LocalizedStringKey("Username"), text: Binding.constant(""))
                Section {
                    TextField(LocalizedStringKey("FirstName"), text: Binding.constant(""))
                    TextField(LocalizedStringKey("LastName"), text: Binding.constant(""))
                }
                Button(LocalizedStringKey("SignUp")) {
                    
                }
            }
            .navigationTitle(LocalizedStringKey("Registration"))
        }
    }
}

struct LocalizationBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        LocalizationBootcamp()
    }
}
