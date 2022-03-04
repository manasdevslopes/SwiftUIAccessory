//
//  DownloadImagesCombine.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 04/03/22.
//

import SwiftUI
// Codable
// background Threads
// weak self
// Combine
// Publishers & Subscribers
// FileManagers
// NSCache

struct DownloadImagesCombine: View {
    @StateObject var vm = DownloadImagesCombineViewModel()
    
    var body: some View {
        NavigationView {
            List{
                ForEach(vm.dataArray) {model in
                    DownloadingImagesRow(model: model)
                }
            }
            .navigationTitle("Downloading Images")
        }
    }
}

struct DownloadImagesCombine_Previews: PreviewProvider {
    static var previews: some View {
        DownloadImagesCombine()
    }
}
