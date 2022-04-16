//
//  LampUIScreen.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 06/04/22.
//

import SwiftUI

struct LampUIScreen: View {
    var body: some View {
        LampUI()
    }
}

struct LampUIScreen_Previews: PreviewProvider {
    static var previews: some View {
        LampUIScreen()
    }
}

struct LampUI : View {
    
    @State var color = 0
    @State var height = UIScreen.main.bounds.height
    @State var width = UIScreen.main.bounds.width
    
    var body: some View{
        VStack {
            ZStack(alignment: .top) {
                VStack {
                    Image(self.color == 0 ? "lamp1" : "lamp2")
                    .resizable()
                    .frame(height: 300)
                    
                    HStack(spacing: 20) {
                        Button(action: {
                            self.color = 0
                        }) {
                            VStack(spacing: 8) {
                                ZStack {
                                    Circle()
                                        .fill(Color.yellow)
                                        .frame(width: 20, height: 20)
                                    Circle()
                                        .stroke(self.color == 0 ? Color.white : Color.clear, lineWidth: 2)
                                        .frame(width: 30, height: 30)
                                }
                                Text("Yellow")
                                    .foregroundColor(.white)
                                    .font(.caption)
                            }
                        }
                        
                        Button(action: {
                            self.color = 1
                        }) {
                            VStack(spacing: 8){
                                ZStack{
                                    Circle()
                                        .fill(Color.orange)
                                        .frame(width: 20, height: 20)
                                    Circle()
                                        .stroke(self.color == 1 ? Color.white : Color.clear, lineWidth: 2)
                                        .frame(width: 30, height: 30)
                                }
                                Text("Orange")
                                    .foregroundColor(.white)
                                    .font(.caption)
                            }
                        }
                    }
                    .padding(.top, 15)
                    .padding(.bottom, 10)
                    
                }
                
                HStack {
                    Button(action: {}) {
                        Image("back")
                            .renderingMode(.original)
                            .padding()
                    }
                    .padding(.leading, 10)
                    .padding(.top, 20)
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image("cart")
                            .renderingMode(.original)
                            .padding()
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, self.height > 800 ? 15 : 10)
                    .background(Color.white)
                    .clipShape(CustomShape(corner: .bottomLeft, radii: self.height > 800 ? 35 : 30))
                }
            }
            .background(self.color == 0 ? Color.yellow : Color.orange)
            .clipShape(CustomShape(corner: .bottomLeft, radii: 55))
            
            ScrollView(self.height > 800 ? .init() : .vertical, showsIndicators: false) {
                VStack {
                    HStack {
                        Text("Melodi Lamp")
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                        Button(action: {}) {
                            Image("heart")
                                .renderingMode(.original)
                                .padding()
                        }
                        .background(self.color == 0 ? Color.yellow : Color.orange)
                        .clipShape(Circle())
                    }
                    .padding(.horizontal, 35)
                    .padding(.top,25)
                    
                    Text("The lampshape provides directional lighting above the dining table and pleasant diffused light throught the room")
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.gray)
                        .padding(.horizontal, 30)
                        .padding(.top,20)
                        .background(CustomShapeLine().fill(self.color == 0 ? Color.yellow.opacity(0.6) : Color.orange.opacity(0.6)))

                    
                    Spacer(minLength: 0)
                    
                    HStack(spacing: 10){
                        Button(action: {}) {
                            VStack{
                                Image("mat1")
                                    .renderingMode(.original)
                                Text("22 W")
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                            }
                            .padding()
                        }
                        .background(Color.black.opacity(0.06))
                        .cornerRadius(12)
                        
                        Button(action: {}) {
                            VStack{
                                Image("mat2")
                                    .renderingMode(.original)
                                Text("24 CM")
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                            }
                            .padding()
                        }
                        .background(Color.black.opacity(0.06))
                        .cornerRadius(12)
                        
                        Button(action: {}) {
                            VStack{
                                Image("mat3")
                                    .renderingMode(.original)
                                Text("26 CM")
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                            }
                            .padding()
                        }
                        .background(Color.black.opacity(0.06))
                        .cornerRadius(12)
                        
                        Button(action: {}) {
                            VStack{
                                Image("mat4")
                                    .renderingMode(.original)
                                Text("1.6 M")
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                            }
                            .padding()
                        }
                        .background(Color.black.opacity(0.06))
                        .cornerRadius(12)
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 25)
                    
                    Spacer(minLength: 0)
                }
            }
            
            HStack {
                Text("$12.99")
                    .foregroundColor(.black)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.leading, 35)
                    .padding(.bottom,25)
                
                Spacer()
                
                Button(action: {}) {
                    Text("Add to Cart")
                        .foregroundColor(.black)
                        .padding(.vertical, 20)
                        .padding(.horizontal, 35)
                }
                .background(self.color == 0 ? Color.yellow : Color.orange)
                .clipShape(CustomShape(corner: .topLeft, radii: 55))
            }
        }
        .edgesIgnoringSafeArea(.all)
        .statusBar(hidden: true)
        .animation(.default, value: color)
    }
}

struct CustomShape: Shape {
    var corner: UIRectCorner
    var radii: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corner, cornerRadii: CGSize(width: radii, height: radii))
        return Path(path.cgPath)
    }
}

struct CustomShapeLine: Shape {
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height - 40))
        }
    }
}
