//
//  BottomDrawers.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 05/01/22.
//

import SwiftUI

struct BottomDrawers: View {
    @State private var showCard: Bool = false
    @State var bottomState = CGSize.zero
    @State var showFull = false
    
    var body: some View {
        ZStack {
            HomeView(showCard: $showCard)
            Text("\(bottomState.height)").offset(y:-300)
            
            GeometryReader { bounds in
                BottomCardView(show: $showCard)
                    .offset(x: 0, y: self.showCard ? bounds.size.height / 2 : bounds.size.height + bounds.safeAreaInsets.top + bounds.safeAreaInsets.bottom)
                    .offset(y: self.bottomState.height)
                    .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8), value: self.bottomState)
                    .gesture(
                        DragGesture().onChanged {value in
                            self.bottomState = value.translation
                            if self.showFull {
                                self.bottomState.height += -300
                            }
                            if self.bottomState.height < -300 {
                                self.bottomState.height = -300
                            }
                        }
                        .onEnded{value in
                            if(self.bottomState.height > 50){
                                self.showCard = false
                            }
                            if(self.bottomState.height < -100 && !self.showFull) || (self.bottomState.height < -250 && self.showFull) {
                                self.bottomState.height = -300
                                self.showFull = true
                            } else {
                                self.bottomState = .zero
                                self.showFull = false
                            }
                        }
                        
                    )
                
            }
        }
        .ignoresSafeArea()
    }
}

struct BottomDrawers_Previews: PreviewProvider {
    static var previews: some View {
        BottomDrawers()
    }
}

struct HomeView: View {
    @Binding var showCard: Bool
    
    var body: some View {
        GeometryReader {geo in
            let frame = geo.frame(in: .global)
            Image("Siblings")
                .resizable()
                .scaledToFill()
                .frame(width: frame.size.width, height: frame.size.height)
                .onTapGesture {
                    withAnimation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8)) {
                        self.showCard.toggle()
                    }
                    
                }
            
        }
    }
}

struct BottomCardView: View {
    @Binding var show: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Rectangle()
                .frame(width: 40, height: 5)
                .cornerRadius(3)
                .opacity(0.1)
            Text("This certificate is proof that Meng To has achieved the UI Design course with approval from a Design+Code instructor.")
                .multilineTextAlignment(.center)
                .font(.subheadline)
                .lineSpacing(4)
            
            Spacer()
            
        }
        .padding(.top, 8)
        .padding(.horizontal, 20)
        .frame(maxWidth: 712)
        .background(BlurView(style: .systemUltraThinMaterial))
        .cornerRadius(30)
        .shadow(radius: 20)
        .frame(maxWidth: .infinity)
    }
}

// Blur View
struct BlurView: UIViewRepresentable {
    let style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}
