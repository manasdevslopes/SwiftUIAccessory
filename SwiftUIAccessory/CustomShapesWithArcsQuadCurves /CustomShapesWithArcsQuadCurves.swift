//
//  CustomShapesWithArcsQuadCurves.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 21/03/22.
//

import SwiftUI

struct CustomShapesWithArcsQuadCurves: View {
    var body: some View {
        ZStack {
            // ArcSample()
            // ShapeWithArc()
            
            WaterShape()
                .fill(
                    LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)), Color(#colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                // .stroke(lineWidth: 5)
                // .frame(width: 200, height: 200)
                // .rotationEffect(Angle(degrees: 90))
                .ignoresSafeArea()
        }
    }
}

struct CustomShapesWithArcsQuadCurves_Previews: PreviewProvider {
    static var previews: some View {
        CustomShapesWithArcsQuadCurves()
    }
}

struct WaterShape: Shape {
    func path(in rect: CGRect) -> Path {
        Path {path in
            path.move(to: CGPoint(x: rect.minX, y: rect.midY))
            path.addQuadCurve(
                to: CGPoint(x: rect.midX, y: rect.midY),
                control: CGPoint(x: rect.width * 0.25, y: rect.height * 0.40))
            
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX, y: rect.midY),
                control: CGPoint(x: rect.width * 0.75, y: rect.height * 0.60))
            
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        }
    }
}

struct QuadeSample: Shape {
    func path(in rect: CGRect) -> Path {
        Path {path in
            path.move(to: .zero)
            path.addQuadCurve(
                //to: CGPoint(x: rect.maxX, y: rect.maxY),
                to: CGPoint(x: rect.midX, y: rect.midY),
                // control: CGPoint(x: rect.minX, y: rect.maxY)
                control: CGPoint(x: rect.maxX - 50, y: rect.minY - 100)
            )
            
        }
    }
}

struct ShapeWithArc: Shape {
    func path(in rect: CGRect) -> Path {
        Path {path in
            // top left
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            // top right
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            // mid right
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            // bottom
            path.addArc(
                center: CGPoint(x: rect.midX, y: rect.midY),
                radius: rect.height / 2,
                startAngle: Angle(degrees: 0),
                endAngle: Angle(degrees: 180),
                clockwise: false)
            // path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            // mid left
            path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        }
    }
}

struct ArcSample: Shape {
    func path(in rect: CGRect) -> Path {
        Path {path in
            path.move(to: CGPoint(x: rect.midX, y: rect.midY))
            path.addArc(
                center: CGPoint(x: rect.midX, y: rect.midY),
                radius: rect.height / 2,
                startAngle: Angle(degrees: -20),
                endAngle: Angle(degrees: 20),
                clockwise: true
            )
        }
    }
}
