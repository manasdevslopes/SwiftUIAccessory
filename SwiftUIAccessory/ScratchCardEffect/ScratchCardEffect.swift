//
//  ScratchCardEffect.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 27/12/21.
//

import SwiftUI

struct ScratchCardEffect: View {
    @State var onFinish: Bool = false
    
    var body: some View {
        VStack {
            ScratchCardView(cursorSize: 50, onFinish: $onFinish) {
                // Body Content
                VStack {
                    Image("trophy")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(10)
                    
                    Text("You've Won!")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.gray)
                    
                    Text("$199.78")
                        .font(.title)
                        .bold()
                        .foregroundColor(.gray)
                        .padding(.top, 5)
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)
            } overlayView: {
                // Overlay Image or View
                Image("scratch")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.ignoresSafeArea())
        .overlay(
            HStack(spacing: 15) {
                Button(action: {}) {
                    Image(systemName: "xmark")
                        .font(.title2)
                        .foregroundColor(.white)
                }
                
                Text("Scratch Card")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                Spacer(minLength: 0)
                
                Button(action: {
                    onFinish = false
                }) {
                    Image("Manas")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                }
            }
                .padding()
            
            , alignment: .top
        )
    }
}

struct ScratchCardEffect_Previews: PreviewProvider {
    static var previews: some View {
        ScratchCardEffect()
    }
}

struct ScratchCardView<Content: View, OverlayView: View>: View {
    var content: Content
    var overlayView: OverlayView
    
    init(cursorSize: CGFloat, onFinish: Binding<Bool>, @ViewBuilder content: @escaping () -> Content, @ViewBuilder overlayView: @escaping () -> OverlayView) {
        self.content = content()
        self.overlayView = overlayView()
        self.cursorSize = cursorSize
        self._onFinish = onFinish
    }
    
    // For Scratch Effect....
    @State var startingPoint: CGPoint = .zero
    @State var points: [CGPoint] = []
    
    // For Gesture Update....
    @GestureState var gestureLocation: CGPoint = .zero
    
    // Customisation and on finish
    var cursorSize: CGFloat
    @Binding var onFinish: Bool
    
    var body: some View {
        ZStack {
            overlayView
                .opacity(onFinish ? 0 : 1)
            content
                .mask(
                    ZStack {
                        if !onFinish {
                            ScratchMask(points: points, startingPoint: startingPoint)
                                .stroke(style: StrokeStyle(lineWidth: cursorSize, lineCap: .round, lineJoin: .round)
                                       )
                        } else {
                            Rectangle()
                        }
                    }
                )
//                .animation(.easeInOut)
                .gesture(
                    DragGesture()
                        .updating($gestureLocation, body: { value, out, _ in
                            out = value.location
                            
                            DispatchQueue.main.async {
                                // Updating starting point
                                // and adding user drag location
                                if startingPoint == .zero {
                                    startingPoint = value.location
                                }
                                points.append(value.location)
                                print("Points------>", points)
                            }
                        })
                        .onEnded({ value in
                            withAnimation {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                    onFinish = true
                                }
                            }
                        })
                )
        }
        .frame(width: 300, height: 300)
        .cornerRadius(20)
        .onChange(of: onFinish) { value in
            if !onFinish && !points.isEmpty {
                withAnimation(.easeInOut) {
                    self.resetView()
                }
            }
        }
    }
    
    func resetView() {
        points.removeAll()
        startingPoint = .zero
    }
}

// Scratch Mask Shape
// It will appear based on user gesture....
struct ScratchMask: Shape {
    var points: [CGPoint]
    var startingPoint: CGPoint
    
    func path(in rect: CGRect) -> Path {
        return Path {path in
            path.move(to: startingPoint)
            path.addLines(points)
        }
    }
}
