//
//  DetailsViewsModel.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 08/04/22.
//

import Foundation

class DetailsViewsModel: ObservableObject {
    @Published var selectedItem = TodayItem(title: "", category: "", overlay: "", contentImage: "", logo: "")
    
    @Published var show: Bool = false
    
    
    
}
