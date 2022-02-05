//
//  Reel.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 05/02/22.
//

import SwiftUI
import AVKit

struct Reel: Identifiable {
    var id = UUID().uuidString
    var player: AVPlayer?
    var mediaFile: MediaFile
}
