//
//  ListViewModel.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 16/04/22.
//

import Foundation

class ListViewModel: ObservableObject {
    @Published var items: [ItemModel] = [] {
        didSet {
            saveItems()
        }
    }
    
    let itemsKey = "items_list"
    
    init() {
        getItems()
    }
    
    /// CRUD - create
    func addItem(title: String) {
        let newItem = ItemModel(title: title, isCompleted: false)
        items.append(newItem)
    }
    
    /// CRUD - retrieve
    func getItems() {
        guard let data = UserDefaults.standard.data(forKey: itemsKey),
              let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data) else { return }
        self.items = savedItems
    }
    
    /// CRUD - update
    func updateItem(item: ItemModel) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item.updateCompletion()
        }
    }
    
    /// CRUD - delete
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
    /// Save
    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
    
    /// Move
    func moveItem(from fromIndexSet: IndexSet, to toIndexSet: Int) {
        items.move(fromOffsets: fromIndexSet, toOffset: toIndexSet)
    }
}
