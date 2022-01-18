//
//  MagnificationGesture.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 18/01/22.
//

import SwiftUI

struct MagnificationGestures: View {
    @State var currentAmount : CGFloat = 0
    @State var lastAmount : CGFloat = 0
    
    var body: some View {
        
            
            VStack(spacing: 10) {
                HStack {
                    Circle().frame(width: 35, height: 35)
                    Text("Manas Vijaywargiya")
                    Spacer()
                    Image(systemName: "ellipsis")
                }
                .padding()
                Rectangle().frame(height: 300)
                    .overlay(
                        Text("\(currentAmount)")
                            .foregroundColor(Color.red)
                    )
                    .scaleEffect(1 + currentAmount)
                    .gesture(
                        MagnificationGesture()
                            .onChanged {value in
                                if currentAmount <= -0.01 {
                                    currentAmount = -0.01
                                }
                                else if currentAmount < 1.52 {
                                    currentAmount = value - 1
                                } else {
                                    currentAmount = 1.52
                                }
    //                                currentAmount = currentAmount < 1.32 ? value - 1 : currentAmount < 0 ? 0 : 1.32
                               
                                
                                
    //                            currentAmount = value - 1
                            }
                            .onEnded { value in
                                withAnimation(.spring()) {
                                    currentAmount = 0
                                }
                            }
                    )
                HStack {
                    Image(systemName: "heart.fill")
                    Image(systemName: "text.bubble.fill")
                    Spacer()
                }
                .padding(.horizontal)
                .font(.headline)
                Text("This is the caption of my photo!")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
            }
            
            
       
//        Text("Hello, World!")
//            .font(.title)
//            .padding(40)
//            .background(Color.red.cornerRadius(10))
//            .scaleEffect(1 + currentAmount + lastAmount)
//            .gesture(
//                MagnificationGesture()
//                    .onChanged { value in
//                        currentAmount = value - 1
//                    }
//                    .onEnded { value in
//                        lastAmount += currentAmount
//                        currentAmount = 0
//                    }
//            )
    }
}

struct MagnificationGestures_Previews: PreviewProvider {
    static var previews: some View {
        MagnificationGestures()
    }
}
