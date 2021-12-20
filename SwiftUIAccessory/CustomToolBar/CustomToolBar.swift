//
//  CustomToolBar.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 20/12/21.
//

import SwiftUI

struct CustomToolBar: View {
    @State var graphicalDate: Bool = false
    @State var showPicker: Bool = false
    @State var show: Bool = false
    @State var dateChanged = Date()
    @State var changePlacement: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Toggle("Show Picker", isOn: $showPicker)
                    Toggle("Show Graphical Date Picker", isOn: $graphicalDate)
                    Text("Date: \(dateChanged)")
                    Text("Change Placement of ToolBar").foregroundColor(.blue).onTapGesture {
                        withAnimation {
                            changePlacement.toggle()
                        }
                    }
                }
                .navigationTitle(Text("Popovers"))
                .toolbar {
                    ToolbarItem(placement: changePlacement ?  .navigationBarTrailing : .navigationBarLeading) {
                        Button(action: {
                            withAnimation {
                                show.toggle()
                            }
                        }) {
                            Image(systemName: "slider.horizontal.below.square.fill.and.square")
                        }
                    }
                }
                .onTapGesture {
                    show = false
                }
            }
        }
        .toolbarPopover(show: $show, placement: changePlacement ? .trailing : .leading) {
            if showPicker {
                Picker(selection: .constant("")) {
                    ForEach(1...10, id: \.self) {index in
                        Text("Hello \(index)")
                            .tag(index)
                    }
                } label: {}
            } else {
                if graphicalDate {
                    DatePicker("", selection: $dateChanged)
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                } else {
                    DatePicker("", selection: $dateChanged)
                        .datePickerStyle(.compact)
                        .labelsHidden()
                }
            }
        }
    }
}

struct CustomToolBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomToolBar()
    }
}
