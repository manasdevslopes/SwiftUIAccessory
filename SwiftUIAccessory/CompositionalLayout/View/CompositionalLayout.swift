//
//  CompositionalLayout.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 30/04/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct CompositionalLayout: View {
    @StateObject var imageFetcher: ImageFetcher = .init()
    
    var body: some View {
        NavigationView {
            Group {
                if let images = imageFetcher.fetchedImages {
                    ScrollView {
                        CompositionalView(items: images, id: \.id) { item in
                            GeometryReader { geo in
                                let size = geo.size
                                WebImage(url: URL(string: item.download_url))
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: size.width, height: size.height)
                                    .cornerRadius(10)
                                    .onAppear {
                                        if images.last?.id == item.id {
                                            imageFetcher.startPagination = true
                                        }
                                    }
                            }
                        }
                        .padding()
                        .padding(.bottom, 10)
                        
                        if imageFetcher.startPagination && !imageFetcher.endPagination {
                            ProgressView()
                                .offset(y: -15)
                                .onAppear {
                                    // MARK: - Slight Delay
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                        imageFetcher.updateImages()
                                    }
                                }
                        }
                    }
                } else {
                    ProgressView()
                }
            }
            .navigationTitle("Compositional Layout")
        }
    }
}

struct CompositionalLayout_Previews: PreviewProvider {
    static var previews: some View {
        CompositionalLayout()
    }
}
