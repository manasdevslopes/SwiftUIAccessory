//
//  Tabs.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 22/12/21.
//

import SwiftUI

struct Food: Identifiable {
    var id = UUID().uuidString
    var title: String
    var description: String
    var price: String
    var image: String
}

let foods = [
    Food(title: "Chocolate Cake", description: "Chocolate cake or chocolate gâteau (from French: gâteau au chocolat) is a cake flavored with melted chocolate, cocoa powder, or both.", price: "$19", image: "chocolates"),
    Food(title: "Cookies", description: "A cookie is a baked or cooked snack or dessert that is typically small, flat and sweet. It usually contains flour, sugar, egg, and some type of oil, fat", price: "$10", image: "cookies"),
    Food(title: "Sandwich", description: "an item of food consisting of two pieces of bread with a filling between them, eaten as a light meal.", price: "$9", image: "sandwich"),
    Food(title: "French Fries", description: "French fries are long, thin pieces of potato fried in oil or fat. The French fries were thin and crispy.", price: "$39", image: "pizza")
]

// Tab Model....
struct Tab: Identifiable {
    var id = UUID().uuidString
    var tab: String
    var foods: [Food]
}

var tabsItems = [
    Tab(tab: "Home Style", foods: foods.shuffled()),
    Tab(tab: "Promotions", foods: foods.shuffled()),
    Tab(tab: "Snacks", foods: foods.shuffled()),
    Tab(tab: "McCafe", foods: foods.shuffled())
]
