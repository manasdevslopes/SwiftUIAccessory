//
//  ScrollViewReaders.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 21/01/22.
//

import SwiftUI

struct ScrollViewReaders: View {
    @State var textFieldText: String = ""
    @State var scrollToIndex: Int = 0
    
    var body: some View {
        VStack {
            TextField("Enter a # here...", text: $textFieldText)
                .frame(height: 55)
                .padding(.horizontal)
                .border(Color.gray)
                .padding(.horizontal)
                .keyboardType(.numberPad)
            
            Button("Scroll Now") {
                withAnimation(.spring()) {
                    if let index = Int(textFieldText) {
                        scrollToIndex = index
                    }
                    // proxy.scrollTo(30, anchor: .center)
                }
            }
            
            ScrollView {
                ScrollViewReader { proxy in
                    //                    Button("Click here to go to #30") {
                    //                        withAnimation(.spring()) {
                    //                            proxy.scrollTo(30, anchor: .center)
                    //                        }
                    //                    }
                    ForEach(0..<50) { index in
                        Text("This is item #\(index)")
                            .font(.headline)
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .padding()
                            .id(index)
                    }
                    .onChange(of: scrollToIndex) { value in
                        withAnimation(.spring()) {
                            proxy.scrollTo(value, anchor: .center)
                        }
                    }
                }
            }
        }
    }
}

struct ScrollViewReaders_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewReaders()
    }
}
