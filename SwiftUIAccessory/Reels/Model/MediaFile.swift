//
//  MediaFile.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 05/02/22.
//

import SwiftUI

// Sample Model And Reel Video
struct MediaFile: Identifiable {
    var id = UUID().uuidString
    var url: String
    var title: String
    var isExpanded: Bool = false
    var songName: String
}

var MediaFileJson = [
    MediaFile(url: "Reel1", title: "Korean Soup...", songName: "Ceal"),
    MediaFile(url: "Reel2", title: "Catch me if you can...", songName: "Run away"),
    MediaFile(url: "Reel3", title: "Main toh darr gyi...🙀😱", songName: "Main toh gar gi"),
    MediaFile(url: "Reel4", title: "Pushpa.... #trending", songName: "Sami-sami"),
    MediaFile(url: "Reel5", title: "Radhe-Krishna", songName: "Radhey-radhey"),
    MediaFile(url: "Reel6", title: "WaterKingdom #Mumbai", songName: "Squid Game Remix"),
    MediaFile(url: "Reel7", title: "Bananza - Belly Dancer #Tranding", songName: "Bananza")
]
