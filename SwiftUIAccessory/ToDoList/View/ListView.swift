//
//  ListView.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 16/04/22.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var listVM: ListViewModel
    @StateObject var hapticVM = HapticViewModel()
    
    var body: some View {
        ZStack {
            Color(hex: "#E5E3D5").ignoresSafeArea()
            
            if listVM.items.isEmpty {
                EmptyItemView()
                    .transition(AnyTransition.opacity.animation(.easeIn))
            } else {
                List {
                    ForEach(listVM.items) { item in
                        ListRowView(item: item)
                            .onTapGesture {
                                hapticVM.impact(style: .heavy)
                                hapticVM.haptic(type: .warning)
                                listVM.updateItem(item: item)
                            }
                    }
                    .onDelete(perform: listVM.deleteItem)
                    .onMove(perform: listVM.moveItem)
                }
                .listStyle(PlainListStyle())
                .padding(.horizontal, 14)
            }
        }
        .navigationTitle("Todo List ✏️")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                if !listVM.items.isEmpty {
                    EditButton()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink("Add", destination: AddView())
            }
        }.accentColor(Color(hex: "#3498DB"))
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListView()
        }
        .environmentObject(ListViewModel())
    }
}
