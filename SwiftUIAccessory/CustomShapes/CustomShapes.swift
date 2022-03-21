//
//  CustomShapes.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 21/03/22.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        Path {path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        }
    }
}

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        Path {path in
            let horizontalOffset: CGFloat = rect.width * 0.2
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX - horizontalOffset, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX + horizontalOffset, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        }
    }
}

struct Trapezoid: Shape {
    func path(in rect: CGRect) -> Path {
        Path {path in
            let horizontalOffset: CGFloat = rect.width * 0.2
            path.move(to: CGPoint(x: rect.minX + horizontalOffset, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX - horizontalOffset, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX + horizontalOffset, y: rect.minY))
        }
    }
}
struct CustomShapes: View {
    var body: some View {
        ZStack {
            // Image("manas_iosdev")
               // .resizable()
               // .scaledToFill()
               // .frame(width: 300, height: 300)
               // .clipShape(
                 //   Triangle()
                 //       .rotation(Angle(degrees: 180))
               // )
            
            Trapezoid()
                .frame(width: 300, height: 100)
            // Diamond()
                // .frame(width: 300, height: 300)
            // Rectangle()
            // Triangle()
                // .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round, dash: [10]))
                // .foregroundColor(.blue)
                // .trim(from: 0, to: 0.5)
                // .fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
              //  .frame(width: 300, height: 300)
            
        }
    }
}

struct CustomShapes_Previews: PreviewProvider {
    static var previews: some View {
        CustomShapes()
    }
}
