//
//  ButtonStyles.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 16/12/21.
//

import SwiftUI
import CoreLocationUI

struct ButtonStyles: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    // 1
                    Button(action: {}) {
                        Text("Bordered")
                            .frame(maxWidth: .infinity)
                    }
                    .tint(.green)
                    .buttonStyle(.bordered)
                    
                    // 2
                    Button(action: {}) {
                        Text("Prominent")
                            .frame(maxWidth: .infinity)
                    }
                    .tint(.green)
                    .buttonStyle(.borderedProminent)
                    
                    // 3
                    Button(role: .destructive, action: {}) {
                        Text("Delete")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderless)
                    
                    // 4
                    Button(role: .cancel, action: {}) {
                        Text("Cancel")
                            .frame(maxWidth: .infinity)
                    }
                    .tint(.yellow)
                    .buttonStyle(.borderless)
                    
                    // 5
                    Button(action: {}) {
                        Text("Small Size")
                            .frame(maxWidth: .infinity)
                    }
                    .tint(.blue)
                    .buttonStyle(.bordered)
                    .controlSize(.small)
                    
                    
                    // 6
                    Button(action: {}) {
                        Text("Mini Size")
                            .frame(maxWidth: .infinity)
                    }
                    .controlSize(.mini)
                    
                    // 7
                    Button(action: {}) {
                        Text("Large Size")
                            .frame(maxWidth: .infinity)
                    }
                    .controlSize(.large)
                    
                    // 8
                    Button("Capsule Button") {}
                    .tint(.pink)
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.capsule)
                    
                    // 9
                    Button("Rounded Rectangle") {}
                    .tint(.pink)
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.roundedRectangle)
                    
                    // 10
                    Button("Rounded Rectangle with radius") {}
                    .tint(.pink)
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.roundedRectangle(radius: 20))
                    .controlSize(.large)
                }
                .padding()
                
                VStack {
                    LocationButton(.sendCurrentLocation){}
                    .labelStyle(.titleAndIcon)
                    
                    LocationButton(.sendCurrentLocation){}
                    .labelStyle(.titleOnly)
                    
                    Button(action: {}) {
                        Text("Gradient Button")
                            .bold()
                            .foregroundColor(.white)
                            .frame(width: 300, height: 35)
                            .background(LinearGradient(colors: [.blue, .pink], startPoint: .leading, endPoint: .trailing))
                            .clipShape(Capsule())
                    }
                    
                    Button(action: {}) {
                        Text("Gradient Button")
                            .bold()
                            .frame(width: 300, height: 35)
                            .overlay(Capsule().stroke(LinearGradient(colors: [.blue, .pink], startPoint: .leading, endPoint: .trailing), lineWidth: 5))
                    }
                    
                    Button(action: {}) {
                        Text("Radial")
                            .bold()
                            .foregroundColor(.white)
                            .frame(width: 100, height: 100)
                            .background(RadialGradient(colors: [.pink, .red, .yellow], center: .center, startRadius: 1, endRadius: 60))
                            .clipShape(Circle())
                    }
                    
                    Button(action: {}) {
                        Text("Angular")
                            .bold()
                            .foregroundColor(.white)
                            .frame(width: 100, height: 100)
                            .background(
                                AngularGradient(gradient: Gradient(colors: [.red, .yellow, .orange, .pink]), center: .center)
                            )
                            .clipShape(Circle())
                    }
                    
                    Button(action: {}) {
                        Label("Learn More", systemImage: "book.fill")
                    }
                    .tint(.green)
                    .buttonStyle(.bordered)
                    
                    Button(action: {}) {
                        Label("Learn More", systemImage: "book.fill")
                    }
                    .foregroundColor(.green)
                    .buttonStyle(.bordered)
                    
                    Button(action: {}) {
                        Label("Learn More", systemImage: "book.fill")
                    }
                    .tint(.green)
                    .buttonStyle(.borderedProminent)
                    
                }
                .padding()
            }
            .navigationTitle("Buttons SwiftUI")
            .toolbar {
                Menu("Options") {
                    Button("Btn 1") {}
                    Button("Delete", role: .destructive) {}
                }
            }
        }
    }
}

struct ButtonStyles_Previews: PreviewProvider {
    static var previews: some View {
        ButtonStyles()
    }
}
