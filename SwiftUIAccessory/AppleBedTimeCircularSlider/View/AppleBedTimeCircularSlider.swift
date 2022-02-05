//
//  AppleBedTimeCircularSlider.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 05/02/22.
//

import SwiftUI

struct AppleBedTimeCircularSlider: View {
    // MARK: - Properties
    @State var startAngle: Double = 0
    // Since our to progress is 0.5
    // 0.5 * 360 = 180
    @State var toAngle: Double = 180
    
    @State var startProgress: CGFloat = 0
    @State var toProgress: CGFloat = 0.5
    
    @State var colorPicker = Color.blue
    
    var body: some View {
        VStack {
            Title()
            
            ColorPicker("Select Color Theme", selection: $colorPicker)
            SleepTimeSlider()
                .padding(.top, 50)
            
            Button(action: {}) {
                Text("Start Sleep")
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .padding(.horizontal, 40)
                    .background(colorPicker, in: Capsule())
            }
            .padding(.top, 45)
            
            HStack(spacing: 25) {
                VStack(alignment: .leading, spacing: 8) {
                    Label {
                        Text("Bedtime")
                            .foregroundColor(.black)
                    } icon: {
                        Image(systemName: "moon.fill")
                            .foregroundColor(colorPicker)
                    }
                    .font(.callout)
                    
                    Text(getTime(angle: startAngle).formatted(date: .omitted, time: .shortened))
                        .font(.title2.bold())
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                VStack(alignment: .leading, spacing: 8) {
                    Label {
                        Text("Wakeup")
                            .foregroundColor(.black)
                    } icon: {
                        Image(systemName: "alarm")
                            .foregroundColor(colorPicker)
                    }
                    .font(.callout)
                    
                    Text(getTime(angle: toAngle).formatted(date: .omitted, time: .shortened))
                        .font(.title2.bold())
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
            }
            .padding()
            .background(.black.opacity(0.06), in: RoundedRectangle(cornerRadius: 15))
            .padding(.top, 35)
            
        }
        .padding()
        //Moving to top without spacer
        .frame(maxHeight: .infinity, alignment: .top)
        
    }
    
    // MARK: - Sleep Time Circular Slider
    @ViewBuilder
    func SleepTimeSlider()-> some View {
        GeometryReader { geo in
            let width = geo.size.width
            
            ZStack {
                // MARK: - Clock Design
                ClockDesign(width: width)
                
                Circle()
                    .stroke(.black.opacity(0.06), lineWidth: 40)
                
                // Allowing Reverse Swiping
                let reverseRotation = (startProgress > toProgress) ? -Double((1 - startProgress) * 360) : 0
                Circle()
                    .trim(from: startProgress > toProgress ? 0 : startProgress, to: toProgress + (-reverseRotation / 360))
                    .stroke(colorPicker, style: StrokeStyle(lineWidth: 40, lineCap: .round, lineJoin: .round))
                    .rotationEffect(.init(degrees: -90))
                    .rotationEffect(.init(degrees: reverseRotation))
                
                // SLider Buttons
                Image(systemName: "moon.fill")
                    .font(.callout)
                    .foregroundColor(colorPicker)
                    .frame(width: 30, height: 30)
                // rotating Image inside the circle
                    .rotationEffect(.init(degrees: 90))
                    .rotationEffect(.init(degrees: -startAngle))
                    .background(.white, in: Circle())
                // Moving to right & rotating
                    .offset(x: width / 2)
                    .rotationEffect(.init(degrees: startAngle))
                    .gesture(
                        DragGesture()
                            .onChanged({ value in
                                onDrag(value: value, fromSlider: true)
                            })
                    )
                    .rotationEffect(.init(degrees: -90))
                
                
                Image(systemName: "alarm")
                    .font(.callout)
                    .foregroundColor(colorPicker)
                    .frame(width: 30, height: 30)
                // rotating Image inside the circle
                    .rotationEffect(.init(degrees: 90))
                    .rotationEffect(.init(degrees: -toAngle))
                    .background(.white, in: Circle())
                // Moving to right & rotating
                    .offset(x: width / 2)
                
                // To the current Angle
                    .rotationEffect(.init(degrees: toAngle))
                    .gesture(
                        DragGesture()
                            .onChanged({ value in
                                onDrag(value: value)
                            })
                    )
                    .rotationEffect(.init(degrees: -90))
                
                // MARK: - Hour Text
                VStack(spacing: 6) {
                    Text("\(getTimeDifference().0)hr")
                        .font(.largeTitle.bold())
                    Text("\(getTimeDifference().1)min")
                        .foregroundColor(.gray)
                }
                .scaleEffect(1.1)
                
            }
        }
        .frame(width: screenBounds().width / 1.6, height: screenBounds().width / 1.6)
    }
    
    func onDrag(value: DragGesture.Value, fromSlider: Bool = false) {
        // MARK: - Converting Translation into Angle
        let vector = CGVector(dx: value.location.x, dy: value.location.y)
        
        // Removing the Buttons Radius
        // Button diameter = 30
        // Radius = 15
        let radians = atan2(vector.dy - 15, vector.dx - 15)
        
        // Converting into Angle
        var angle = radians * 180 / .pi
        if angle < 0 {angle = 360 + angle}
        
        // Progress
        let progress = angle / 360
        
        if fromSlider {
            // Update From Values
            self.startAngle = angle
            self.startProgress = progress
            HapticManager.instance.notification(type: .success)
        } else {
            // Update To Values
            self.toAngle = angle
            self.toProgress = progress
            HapticManager.instance.notification(type: .success)
        }
    }
    
    // MARK: - Returning Time based on Rotation
    func getTime(angle: Double)-> Date {
        // 360 / 12 = 30
        // 12 = Hours
        let progress = angle / 30
        
        // It will be 6.05
        // 6 is hours
        // 0.5 in minutes
        let hour = Int(progress)
        // Why 12
        // Since we're going to update time for each 5minutes not for each minute
        // 0.1 = 5 minutes
        let remainder = (progress.truncatingRemainder(dividingBy: 1) * 12).rounded()
        
        var minute = remainder * 5
        minute = (minute > 55 ? 55 : minute)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm:ss"
        if let date = formatter.date(from: "\(hour):\(Int(minute)):00") {
            return date
        }
        return .init()
    }
    
    func getTimeDifference() -> (Int, Int) {
        let calendar = Calendar.current
        let result = calendar.dateComponents([.hour, .minute], from: getTime(angle: startAngle), to: getTime(angle: toAngle))
        return (result.hour ?? 0, result.minute ?? 0)
    }
}

struct AppleBedTimeCircularSlider_Previews: PreviewProvider {
    static var previews: some View {
        AppleBedTimeCircularSlider()
        
    }
}

struct Title: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("Today")
                    .font(.title.bold())
                
                Text("Good Morning! Manas")
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Button(action: {}) {
                Image("Manas9")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 70, height: 70,alignment: .top)
                    .clipShape(Circle())
            }
        }
    }
}

// MARK: - Extensions
extension View {
    // MARK: - Screen Bound Extension
    func screenBounds()->CGRect {
        return UIScreen.main.bounds
    }
}

struct ClockDesign: View {
    let width: CGFloat
    var body: some View {
        ZStack {
            ForEach(1...60, id: \.self){ index in
                Rectangle()
                    .fill(index % 5 == 0 ? .black : .gray)
                // Each hour will have big line
                // 60/5 = 12
                // 12 hours
                    .frame(width: 2, height: index % 5 == 0 ? 10 : 5)
                // setting into entire Circle
                    .offset(y: (width - 60) / 2)
                    .rotationEffect(.init(degrees: Double(index) * 6))
            }
            
            // MARK: - Clock Text
            let texts = [6, 9, 12, 3]
            ForEach(texts.indices, id:\.self) { index in
                Text("\(texts[index])")
                    .font(.caption.bold())
                    .foregroundColor(.black)
                    .rotationEffect(.init(degrees: Double(index) * -90))
                    .offset(y: (width - 90) / 2)
                // 360/4 = 90
                    .rotationEffect(.init(degrees: Double(index) * 90))
            }
        }
    }
}
