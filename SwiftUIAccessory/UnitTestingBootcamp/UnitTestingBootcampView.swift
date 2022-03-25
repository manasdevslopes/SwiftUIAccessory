//
//  UnitTestingBootcampView.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 24/03/22.
//

import SwiftUI

struct UnitTestingBootcampView: View {
    @StateObject private var vm: UnitTestingBootcampViewViewModel
    
    init(isPremium: Bool) {
        _vm = StateObject(wrappedValue: UnitTestingBootcampViewViewModel(isPremium: isPremium))
    }
    
    var body: some View {
        Text(vm.isPremium.description)
    }
}

struct UnitTestingBootcampView_Previews: PreviewProvider {
    static var previews: some View {
        UnitTestingBootcampView(isPremium: true)
    }
}
