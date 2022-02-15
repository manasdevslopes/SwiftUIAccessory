//
//  CoreDataBootCamp.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 15/02/22.
//

import SwiftUI

struct CoreDataBootCamp: View {
    @StateObject var coreDataVM = CoreDataViewModel()
    @State var textFieldText: String = ""
    let textFieldColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
    let saveButtonColor = #colorLiteral(red: 1, green: 0.1857388616, blue: 0.5733950138, alpha: 1)
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Add Fruit here...", text: $textFieldText)
                    .font(.headline)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(textFieldColor))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Button(action: {
                    guard !textFieldText.isEmpty else { return }
                    coreDataVM.addFruit(text: textFieldText)
                    textFieldText = ""
                }) {
                    Text("Save")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color(saveButtonColor))
                        .cornerRadius(10)
                }
                .padding(.horizontal)

                List {
                    ForEach(coreDataVM.savedEntities) {entity in
                        Text(entity.name ?? "No Name")
                            .onTapGesture {
                                coreDataVM.updateFruit(entity: entity)
                            }
                    }
                    .onDelete(perform: coreDataVM.deleteFruit)
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Fruits")
        }
    }
}

struct CoreDataBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataBootCamp()
    }
}
