//
//  CountdownSwiftUI.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 19/04/22.
//

import SwiftUI

struct CountdownSwiftUI: View {
    var body: some View {
        CountDownUI()
    }
}

struct CountdownSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        CountdownSwiftUI()
    }
}

struct CountDownUI: View {
    @State private var showpop = false
    
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            
            RoundedRectangle(cornerRadius: 25.0)
                .foregroundColor(Color("darkb"))
                .frame(width: 320, height: 360, alignment: .center)
                .overlay(RoundedRectangle(cornerRadius: 25.0).stroke(Color.white, lineWidth: 2))
                .offset(x: 0, y: -19)
            
            RoundedRectangle(cornerRadius: 25.0)
                .foregroundColor(.gray.opacity(0.2))
                .frame(width: 320, height: 320, alignment: .center)
                .overlay(RoundedRectangle(cornerRadius: 25.0).stroke(Color.white, lineWidth: 2))
            
            HStack{
                Circle().foregroundColor(.red)
                    .frame(width: 18, height: 18, alignment: .center)
                Circle().foregroundColor(.yellow)
                    .frame(width: 18, height: 18, alignment: .center)
                Circle().foregroundColor(.green)
                    .frame(width: 18, height: 18, alignment: .center)
            }.offset(x: -95, y: -178)
            
            ZStack{
                ZStack {
                    Button(action: {
                        self.showpop.toggle()
                    }){
                        ButtonPlayView()
                    }
                    if showpop {
                        TimerSection(showpop: $showpop)
                    }
                }
            }
        }
    }
}

struct ButtonPlayView: View {
    var body: some View {
        ZStack{
            Circle()
                .stroke(Color.gray, lineWidth: 10).opacity(0.3)
                .frame(width: 180, height: 180, alignment: .center)
            Image(systemName: "play.fill")
                .resizable()
                .foregroundColor(.white)
                .frame(width: 60, height: 60, alignment: .center)
                .offset(x: 5, y: 0)
            Text("C O U N T D O W N")
                .font(.title)
                .fontWeight(.light)
                .foregroundColor(Color.white)
                .offset(x: 0, y: 136)
        }.offset(x: 0, y: -42)
    }
}

struct TimerSection: View {
    @State var circlerotate  = false
    @State var circlerotate2  = false
    @State private var border : CGFloat = 0.01
    @State private var border2 : CGFloat = 0.01
    @State var timeRemaining = 30
    @Binding var showpop: Bool
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .foregroundColor(Color("lightb"))
                .frame(width: 320, height: 320, alignment: .center)
                .overlay(RoundedRectangle(cornerRadius: 25.0).stroke(Color.white, lineWidth: 2))
            VStack {
                ZStack {
                    Circle()
                        .stroke(Color.gray, lineWidth: 10).opacity(0.3)
                        .frame(width: 190, height: 190, alignment: .center)
                        .offset(x: 0, y: 20)
                    ZStack {
                        Circle()
                            .trim(from: 0.0, to:  self.border)
                            .stroke(Color.white, lineWidth: 10)
                            .frame(width: 190, height: 190, alignment: .center)
                            .rotationEffect(.degrees(circlerotate ? 180 : -180))
                            .animation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: false), value: circlerotate)
                            .onAppear() {
                                self.circlerotate.toggle()
                            }
                        Circle()
                            .trim(from: 0.0, to:  self.border)
                            .stroke(Color.white, lineWidth: 10)
                            .frame(width: 190, height: 190, alignment: .center)
                            .rotationEffect(.degrees(circlerotate2 ? -180 : 180))
                            .animation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: false), value: circlerotate2)
                            .onAppear() {
                                self.circlerotate2.toggle()
                            }
                    }.rotationEffect(.degrees(90)).offset(x: 0, y: 20)
                    
                    // MARK: - Animation Sequence code
                    animationSequence()
                        .offset(x: 116, y: 260)
                }
                
                Text("\(timeRemaining)").foregroundColor(.white)
                    .fontWeight(.light)
                    .font(.system(size: 80))
                    .onReceive(timer) { _ in
                        if timeRemaining > 0 {
                            timeRemaining -= 1
                        } else {
                            circlerotate = false
                            circlerotate2 = false
                            timeRemaining = 30
                            self.showpop = false
                        }
                    }.offset(x: 0, y: -230)
            }
        }
    }
}

var images : [UIImage]! = [
    UIImage(named: "image0")!,
    UIImage(named: "image1")!,
    UIImage(named: "image2")!,
    UIImage(named: "image3")!,
    UIImage(named: "image4")!,
    UIImage(named: "image5")!,
    UIImage(named: "image6")!,
    UIImage(named: "image7")!,
    UIImage(named: "image8")!,
    UIImage(named: "image9")!,
    UIImage(named: "image10")!,
    UIImage(named: "image11")!,
    UIImage(named: "image12")!,
    UIImage(named: "image13")!,
    UIImage(named: "image14")!,
    UIImage(named: "image15")!,
    UIImage(named: "image16")!,
    UIImage(named: "image17")!,
    UIImage(named: "image18")!,
    UIImage(named: "image19")!,
    UIImage(named: "image20")!,
    UIImage(named: "image21")!,
    UIImage(named: "image22")!,
    UIImage(named: "image23")!,
    UIImage(named: "image24")!,
    UIImage(named: "image25")!,
    UIImage(named: "image26")!,
    UIImage(named: "image27")!,
    UIImage(named: "image28")!
]

let animatedImages = UIImage.animatedImage(with: images, duration: 0.8)
struct animationSequence : UIViewRepresentable{
    func makeUIView(context: Context) -> some UIView {
        let seqAnimview = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let seqImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 160, height: 160))
        seqImage.clipsToBounds = true
        seqImage.layer.cornerRadius = 20
        seqImage.autoresizesSubviews = true
        seqImage.contentMode = UIView.ContentMode.scaleAspectFill
        seqImage.image = animatedImages
        seqAnimview.addSubview(seqImage)
        return seqAnimview
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}
