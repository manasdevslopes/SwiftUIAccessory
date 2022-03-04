//
//  ImageLoadingViewModel.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 04/03/22.
//

import Foundation
import SwiftUI
import Combine

class ImageLoadingViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    var cancellables = Set<AnyCancellable>()
    
    // let manager = PhotoModelCacheManager.instance
    let manager = PhotoModelFileManager.instance

    let urlString: String
    let imageKey: String

    init(url: String, key: String) {
        urlString = url
        imageKey = key
        getImage()
    }
    
    func getImage() {
        if let savedImage = manager.getImage(key: imageKey) {
            image = savedImage
            print("Getting saved Image!")
        } else {
            downloadImage()
            print("Downloading Image now!")
        }
    }
    
    func downloadImage() {
        isLoading = true
        guard let url = URL(string: urlString) else {
            isLoading = false
            return
        }
        URLSession.shared.dataTaskPublisher(for: url)
            // .map { (data, response) -> UIImage? in
               // return UIImage(data: data)
            // }
            .map { UIImage(data: $0.data )}
            .receive(on: DispatchQueue.main)
            .sink {[weak self] _ in
                self?.isLoading = false
            } receiveValue: {[weak self] (returnedImage) in
                guard let self = self,
                      let image = returnedImage else { return }
                
                self.image = returnedImage
                self.manager.add(key: self.imageKey, value: image)
            }
            .store(in: &cancellables)
    }
}
