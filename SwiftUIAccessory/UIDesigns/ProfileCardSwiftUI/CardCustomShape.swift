//
//  CardCustomShape.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 20/04/22.
//

import SwiftUI


struct CardCustomShape: Shape {
    var corner : UIRectCorner
    var radii : CGFloat

    func path(in rect : CGRect) -> Path{
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corner, cornerRadii: CGSize(width: radii, height: radii))
        return Path(path.cgPath)
    }
}
