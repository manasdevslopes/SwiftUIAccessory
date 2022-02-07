//
//  HashableProtocol.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 07/02/22.
//

import SwiftUI


struct MyCustomModel1: Hashable {
    let title: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        // if there are multiple properties in model and if we want to combine 2 or more properties to create hash value then use this
        // hasher.combine(title+subtitle)
    }
}

struct HashableProtocol2: View {
    let data: [MyCustomModel1] = [
        MyCustomModel1(title: "ONE"),
        MyCustomModel1(title: "TWO"),
        MyCustomModel1(title: "THREE"),
        MyCustomModel1(title: "FOUR"),
        MyCustomModel1(title: "FIVE"),
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                ForEach(data, id: \.self) {item in
                    HStack {
                        Text(item.title)
                            .font(.headline)
                        Text(item.hashValue.description)
                            .font(.headline)
                    }
                }
            }
        }
    }
}


struct MyCustomModel: Identifiable {
    var id = UUID().uuidString
    let title: String
}

struct HashableProtocol1: View {
    let data: [MyCustomModel] = [
        MyCustomModel(title: "ONE"),
        MyCustomModel(title: "TWO"),
        MyCustomModel(title: "THREE"),
        MyCustomModel(title: "FOUR"),
        MyCustomModel(title: "FIVE"),
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                ForEach(data) {item in
                    HStack {
                        Text(item.title)
                            .font(.headline)
                        Text(item.id)
                            .font(.headline)
                    }
                }
            }
        }
    }
}


struct HashableProtocol: View {
    let data: [String] = [
        "ONE", "TWO", "THREE", "FOUR", "FIVE"
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                ForEach(data, id: \.self) {item in
                    HStack {
                        Text(item)
                            .font(.headline)
                        Text(item.hashValue.description)
                            .font(.headline)
                    }
                }
            }
        }
    }
}

struct HashableProtocol_Previews: PreviewProvider {
    static var previews: some View {
        HashableProtocol2()
    }
}
