//
//  SoundEffects.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 21/01/22.
//

import SwiftUI
import AVKit

class SoundManager {
    // Singleton - Everytime when to use this class in UI, no need to write instance everytime just use this singleton instance.
    static let instance = SoundManager()

    var player: AVAudioPlayer?
    
    enum SoundOption: String {
        // here, we r giving : String, so that each case - tada is having tada value. And if we want to explicitly give string value then we can write it as case tada = "tada"
        case tada
        case badum
    }
    
    func playSound(sound: SoundOption) {
        guard let url =
//                URL(string: "")
                Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3")
        else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error playing sound. \(error.localizedDescription)")
        }
    }
}

struct SoundEffects: View {
    var body: some View {
        VStack(spacing: 40) {
            Button("Play Sound 1") {
                SoundManager.instance.playSound(sound: .tada)
            }
            
            Button("Play Sound 2") {
                SoundManager.instance.playSound(sound: .badum)
            }
        }
    }
}

struct SoundEffects_Previews: PreviewProvider {
    static var previews: some View {
        SoundEffects()
    }
}
