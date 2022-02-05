//
//  ReelsView.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 05/02/22.
//

import SwiftUI
import AVKit

struct ReelsView: View {
    @State var currentReel = ""
    
    // Extracting AVPlayer from media file
    @State var reels = MediaFileJson.map { item -> Reel in
        let url = Bundle.main.path(forResource: item.url, ofType: "MP4") ?? ""
        let player = AVPlayer(url: URL(fileURLWithPath: url))
        
        return Reel(player: player, mediaFile: item)
        
    }
    var body: some View {
        GeometryReader{ geo in
            let size = geo.size
            
            // Vertical Page Tab View...
            TabView(selection: $currentReel) {
                ForEach($reels) {$reel in
                    ReelsPlayer(reel: $reel, currentReel: $currentReel)
                        .frame(width: size.width)
                        .rotationEffect(.init(degrees: -90))
                        .ignoresSafeArea(.all, edges: .top)
                        .tag(reel.id)
                }
            }
            .rotationEffect(.init(degrees: 90))
            .frame(width: size.height)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(width: size.width)
        }
        .ignoresSafeArea(.all, edges: .top)
        .background(Color.black.ignoresSafeArea())
        // setting initial reel
        .onAppear {
            currentReel = reels.first?.id ?? ""
        }
    }
}

struct ReelsView_Previews: PreviewProvider {
    static var previews: some View {
        ReelsView()
    }
}


struct ReelsPlayer: View {
    @Binding var reel: Reel
    
    @Binding var currentReel : String
    
    @State var showMore = false
    
    @State var isMuted = false
    @State var volumeAnimation = false
    
    var body: some View {
        ZStack {
            
            if let player = reel.player {
                CustomVideoPlayer(player: player)
                
                // Playing video based on offset
                GeometryReader { proxy -> Color in
                    let minY = proxy.frame(in: .global).minY
                    
                    let size = proxy.size
                    
                    DispatchQueue.main.async {
                        if -minY < (size.height / 2) && minY < (size.height / 2) && currentReel == reel.id {
                            player.play()
                        } else{
                            player.pause()
                        }
                    }
                    
                    return Color.clear
                }
                // Volume control
                Color.black
                    .opacity(0.01)
                    .frame(width: 150, height: 150)
                    .onTapGesture {
                        if volumeAnimation {
                            return
                        }
                        isMuted.toggle()
                        // Muting player
                        player.isMuted = isMuted
                        
                        withAnimation {volumeAnimation.toggle()}
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                            withAnimation {volumeAnimation.toggle()}
                        }
                    }
                
                // Dimming background when showing more content
                Color.black.opacity(showMore ? 0.35 : 0)
                    .onTapGesture {
                        withAnimation {
                            self.showMore.toggle()
                        }
                    }
                
                VStack {
                    HStack(alignment: .bottom) {
                        VStack(alignment: .leading, spacing: 10) {
                            HStack(spacing: 15) {
                                Image("Manas")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 35, height: 35)
                                    .clipShape(Circle())
                                
                                Text("manas_iosdev")
                                    .font(.callout.bold())
                                
                                Button(action: {}) {
                                    Text("Follow")
                                        .font(.caption.bold())
                                }
                            }
                            
                            // Custom text view....
                            ZStack {
                                if showMore {
                                    ScrollView(.vertical, showsIndicators: false) {
                                        Text(reel.mediaFile.title+sampleText)
                                            .font(.callout)
                                            .fontWeight(.semibold)
                                    }
                                    .frame(height: 120)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .onTapGesture {
                                        withAnimation {
                                            self.showMore.toggle()
                                        }
                                    }
                                } else {
                                    Button(action: {
                                        withAnimation {
                                            self.showMore.toggle()
                                        }
                                    }) {
                                        HStack {
                                            Text(reel.mediaFile.title)
                                                .font(.callout)
                                                .fontWeight(.semibold)
                                                .lineLimit(1)
                                            
                                            Text("more")
                                                .font(.callout.bold())
                                                .foregroundColor(.gray)
                                        }
                                        .padding(.top, 5)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                }
                            }
                        }
                        
                        Spacer(minLength: 20)
                        
                        ActionButtons(reel: reel)
                    }
                    
                    // Music View
                    HStack {
                        Text(reel.mediaFile.songName)
                            .font(.caption)
                            .fontWeight(.semibold)
                        Spacer(minLength: 20)
                        Image("Manas11")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 30, height: 30, alignment: .top)
                            .cornerRadius(6)
                            .background(
                                RoundedRectangle(cornerRadius: 6).stroke(Color.white, lineWidth: 3)
                            )
                            .offset(x: -5)
                    }
                    .padding(.top, 10)
                    
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
                .foregroundColor(.white)
                .frame(maxHeight: .infinity, alignment: .bottom)
                
                Image(systemName: isMuted ? "speaker.slash.fill" : "speaker.wave.2.fill")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(.secondary)
                    .clipShape(Circle())
                    .foregroundStyle(.black)
                    .opacity(volumeAnimation ? 1 : 0)
            }
        }
    }
}

let sampleText = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."

struct ActionButtons: View {
    var reel: Reel
    
    var body: some View {
        VStack(spacing: 25) {
            Button(action: {}) {
                VStack(spacing: 10) {
                    Image(systemName: "suit.heart")
                        .font(.title)
                    Text("223K")
                        .font(.caption.bold())
                }
            }
            
            Button(action: {}) {
                VStack(spacing: 10) {
                    Image(systemName: "bubble.right")
                        .font(.title)
                    Text("120")
                        .font(.caption.bold())
                }
            }
            
            Button(action: {}) {
                VStack(spacing: 10) {
                    Image(systemName: "paperplane")
                        .font(.title)
                }
            }
            
            Button(action: {}) {
                Image(systemName: "ellipsis")
                    .font(.title)
                    .frame(width: 20, height: 20)
                
            }
        }
    }
}
