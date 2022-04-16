//
//  EmptyItemView.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 16/04/22.
//

import SwiftUI

struct EmptyItemView: View {
    @State var animate: Bool = false
    let secondaryAccentColor = Color(hex: "#531B93")
    let tertiaryColor = Color(hex: "#941651")
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 10) {
                Text("There are no items!")
                    .font(.title)
                    .fontWeight(.semibold)
                Text("Do you love to cook foods? Shortage of ingredients. Click on add button and add a bunch of items to your todo list!.")
                    .padding(.bottom, 20)
                NavigationLink(destination: AddView()) {
                    Text("Add Something 🥳")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(animate ? tertiaryColor : secondaryAccentColor)
                        .cornerRadius(10)
                }
                .padding(.horizontal, animate ? 30 : 50)
                .shadow(color: animate ? tertiaryColor.opacity(0.7) : secondaryAccentColor.opacity(0.7), radius: animate ? 30 : 10, x: 0, y: animate ? 50 : 30)
                .scaleEffect(animate ? 1.1 : 1.0)
                .offset(y: animate ? -7 : 0)
            }
            .frame(maxWidth: 400)
            .multilineTextAlignment(.center)
            .padding(40)
            .onAppear(perform: addAnimation)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

extension EmptyItemView {
    func addAnimation() {
        guard !animate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(Animation.easeInOut(duration: 2).repeatForever()) {
                animate.toggle()
            }
        }
    }
}
struct EmptyItemView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyItemView()
    }
}
