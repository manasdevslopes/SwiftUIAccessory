//
//  Copy&PasteText.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 14/08/22.
//

import SwiftUI

struct Copy_PasteText: View {
    var body: some View {
        Text("Hello, World!")
        .textSelection(.enabled)
    }
}

struct Copy_PasteText_Previews: PreviewProvider {
    static var previews: some View {
        Copy_PasteText()
    }
}
