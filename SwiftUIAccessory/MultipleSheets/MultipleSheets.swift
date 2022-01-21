//
//  MultipleSheets.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 21/01/22.
//

import SwiftUI

struct RandomModel: Identifiable {
    let id = UUID().uuidString
    let title: String
}

// 3 ways to use
// 1. using @Binding
// 2. using multiple sheets
// 3. use $item

struct MultipleSheets: View {
    //    @State var selectedModel: RandomModel = RandomModel(title: "STARTING TITLE")
    @State var selectedModel: RandomModel? = nil
    //    @State var showSheet: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(0..<10){ index in
                    Button("Button\(index)") {
                        selectedModel = RandomModel(title: "\(index)")
                        //                showSheet.toggle()
                    }
                }
            }
            //        .sheet(isPresented: $showSheet) {
            //            NextScreen(selectedModel: $selectedModel)
            //        }
            .sheet(item: $selectedModel) { model in
                NextScreen(selectedModel: model)
            }
        }
    }
}

struct NextScreen: View {
    //    @Binding var selectedModel: RandomModel
    let selectedModel: RandomModel
    
    var body: some View {
        Text(selectedModel.title)
            .font(.headline)
    }
}
struct MultipleSheets_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSheets()
    }
}
