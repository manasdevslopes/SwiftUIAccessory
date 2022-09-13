  //
  //  Swift_SwiftUI_Logo.swift
  //  SwiftUIAccessory
  //
  //  Created by MANAS VIJAYWARGIYA on 13/09/22.
  //

import SwiftUI

struct Swift_SwiftUI_Logo: Shape {
  func path(in rect: CGRect) -> Path {
    var path = Path()
    let width = rect.width
    let height = rect.height
    
    let startPoint = CGPoint(x: rect.minX, y: height * 0.63)
    
    path.move(to: startPoint)
    path.addCurve(to: CGPoint(x: width * 0.98, y: height * 0.93),
                  control1: CGPoint(x: width * 0.5, y: height * 1.2),
                  control2: CGPoint(x: width * 0.85, y: height * 0.7))
    path.addQuadCurve(to: CGPoint(x: width * 0.9, y: height * 0.68),
                      control: CGPoint(x: width, y: height * 0.8))
    path.addQuadCurve(to: CGPoint(x: width * 0.61, y: rect.minY),
                      control: CGPoint(x: width, y: height * 0.3))
    path.addQuadCurve(to: CGPoint(x: width * 0.7, y: height * 0.53),
                      control: CGPoint(x: width * 0.78, y: height * 0.3))
    
    path.addQuadCurve(to: CGPoint(x: width * 0.215, y: height * 0.09),
                      control: CGPoint(x: width * 0.35, y: height * 0.25))
    
    path.addQuadCurve(to: CGPoint(x: width * 0.5, y: height * 0.48),
                      control: CGPoint(x: width * 0.3, y: height * 0.25))
    
    path.addQuadCurve(to: CGPoint(x: width * 0.1, y: height * 0.15),
                      control: CGPoint(x: width * 0.35, y: height * 0.4))
    
    path.addQuadCurve(to: CGPoint(x: width * 0.56, y: height * 0.71),
                      control: CGPoint(x: width * 0.33, y: height * 0.51))
    
    path.addQuadCurve(to: startPoint,
                      control: CGPoint(x: width * 0.3, y: height * 0.85))
    
    return path
  }
}

struct Swift_SwiftUI_Logos: View {
  var body: some View {
    HStack {
      SwiftLogo()
      
      SwiftUILogo()
    }
  }
}

struct Swift_SwiftUI_Logo_Previews: PreviewProvider {
  static var previews: some View {
    Swift_SwiftUI_Logos()
      .previewInterfaceOrientation(.landscapeRight)
  }
}

struct SwiftLogo: View {
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 100, style: .continuous)
        .fill(
          LinearGradient(
            colors: [
              Color(red: 253.0/255, green: 38.0/255, blue: 33.0/255),
              Color(red: 248.0/255, green: 137.0/255, blue: 54.0/255)
            ], startPoint: .bottomTrailing, endPoint: .topLeading)
        )
      Swift_SwiftUI_Logo()
        .fill(.white)
        .padding(75)
    }
    .padding(50)
    .aspectRatio(1, contentMode: .fit)
    .previewInterfaceOrientation(.landscapeLeft)
  }
}

struct SwiftUILogo: View {
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 100, style: .continuous)
        .fill(
          LinearGradient(
            colors: [
              Color(red: 1.0/255, green: 44.0/255, blue: 157.0/255),
              Color(red: 92.0/255, green: 217.0/255, blue: 235.0/255)
            ], startPoint: .bottomTrailing, endPoint: .topLeading)
        )
      Swift_SwiftUI_Logo()
        .fill(.black)
        .padding(75)
    }
    .padding(50)
    .aspectRatio(1, contentMode: .fit)
    .previewInterfaceOrientation(.landscapeLeft)
  }
}
