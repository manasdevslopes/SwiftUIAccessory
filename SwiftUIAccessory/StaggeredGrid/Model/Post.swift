//
//  Post.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 17/12/21.
//

import Foundation

struct Post: Identifiable, Hashable {
    var id = UUID().uuidString
    var imageURL: String
}
