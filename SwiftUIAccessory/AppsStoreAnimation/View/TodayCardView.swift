//
//  TodayCardView.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 08/04/22.
//

import SwiftUI

struct TodayCardView: View {
    var item: TodayItem
    
    @Environment(\.colorScheme) var color
    var todayAnimation: Namespace.ID
    
    var body: some View {
        VStack {
            Image(item.contentImage)
                .resizable()
                .matchedGeometryEffect(id: item.contentImage, in: todayAnimation)
                .frame(width: UIScreen.main.bounds.width - 30, height: 250)
                .aspectRatio(contentMode: .fill)
            
            HStack {
                Image(item.logo)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 65, height: 65)
                    .cornerRadius(15)
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(item.title)
                        .fontWeight(.bold)
                    Text(item.category)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Spacer(minLength: 0)
                
                VStack {
                    Button(action: {}) {
                        Text("GET")
                            .fontWeight(.bold)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 25)
                            .background(Color.primary.opacity(0.1))
                            .clipShape(Capsule())
                    }
                    Text("In App Purchases")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .matchedGeometryEffect(id: item.id, in: todayAnimation)
            .padding(.horizontal)
            .padding(.bottom, 8)
            
        }
        .background(color == .dark ? Color.black : Color.white)
        .cornerRadius(15)
        .padding(.horizontal)
        .padding(.top)
    }
}


