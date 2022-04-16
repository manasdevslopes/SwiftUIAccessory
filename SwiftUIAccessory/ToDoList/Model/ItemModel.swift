//
//  ItemModel.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 16/04/22.
//

import Foundation

/// Immutable struct - mention as a let & not var
struct ItemModel: Identifiable, Codable {
    let id: String
    let title: String
    let isCompleted: Bool
    
    init(id: String = UUID().uuidString, title: String, isCompleted: Bool) {
        self.id = UUID().uuidString
        self.title = title
        self.isCompleted = isCompleted
    }
    
    func updateCompletion() -> ItemModel {
        return ItemModel(id: id, title: title, isCompleted: !isCompleted)
    }
}
