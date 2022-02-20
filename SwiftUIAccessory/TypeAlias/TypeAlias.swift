//
//  TypeAlias.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 20/02/22.
//

import SwiftUI

/*
 Typealias: - To create a name for an existing type so this is a great way to create subnames of existing models and existing types in the app that might be a little more applicable to the part of code in the app that we are working on
 
 
 */

struct MovieModel {
    let title: String
    let director: String
    let count: Int
}

//struct TVModel {
//    let title: String
//    let director: String
//    let count: Int
//}

typealias TVModel = MovieModel

struct TypeAlias: View {
//    @State var item: MovieModel = MovieModel(title: "Title", director: "Joe", count: 5)
    @State var item: TVModel = TVModel(title: "TV  Title", director: "Emily", count: 10)
    
    var body: some View {
        VStack {
            Text(item.title)
            Text(item.director)
            Text("\(item.count)")
        }
    }
}

struct TypeAlias_Previews: PreviewProvider {
    static var previews: some View {
        TypeAlias()
    }
}
