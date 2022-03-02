//
//  CacheBootcamp.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 02/03/22.
//

import SwiftUI

class CacheManager {
    static let instance = CacheManager()
    
    // if we put private init() {}
    private init() {} // we can't make instance again in any other class of CacheManager. It will give error as 'CacheManager' initializer is inaccessible due to 'private' protection level

    // computed Property and initialise it with '()'
    // NSCache requires to put dictionary as key - value pair. So key is basically name of the image that is in 'String' but we need to use NS before String. And value is as UIImage
    var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100 // 100MB
        return cache
    }()

    func add(image: UIImage, name: String) -> String {
        imageCache.setObject(image, forKey: name as NSString)
        return "Added to cached!"
    }
    
    func remove(name: String) -> String {
        imageCache.removeObject(forKey: name as NSString)
        return "Image removed from cached!"
    }
    
    func getImage(name: String) -> UIImage? {
        return imageCache.object(forKey: name as NSString)
    }

}

class CacheBootcampViewModel: ObservableObject {
    @Published var startingImage: UIImage? = nil
    @Published var cachedImage: UIImage? = nil
    @Published var infoMsg: String = ""
    
    let imageName = "Manas"
    
    // Cant make instance again due to private protection level above
    // let newManager = CacheManager()
    
    let manager = CacheManager.instance
    
    init() {
        getImageFromAssetFolder()
    }
    
    func saveToCache() {
        guard let image = startingImage else { return }
        infoMsg = manager.add(image: image, name: imageName)
        getImageFromCache()
    }
    
    func removeFromCache() {
        infoMsg = manager.remove(name: imageName)
         cachedImage = nil
        // getImageFromCache()
    }
    
    func getImageFromCache() {
        if let returnedImge = manager.getImage(name: imageName) {
            cachedImage = returnedImge
        }
    }
    
    func getImageFromAssetFolder() {
        startingImage = UIImage(named: imageName)
    }
    
}

struct CacheBootcamp: View {
    @StateObject var vm = CacheBootcampViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if let image = vm.startingImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                }
                Text(vm.infoMsg)
                    .font(.headline)
                    .foregroundColor(.purple)
                
                HStack {
                    Button(action: {
                        vm.saveToCache()
                    }) {
                        Text("Save to Cache")
                            .frame(maxWidth: .infinity)
                    }
                    .tint(.green)
                    .buttonStyle(.bordered)
                    
                    Button(action: {
                        vm.removeFromCache()
                    }) {
                        Text("Delete from Cache")
                            .frame(maxWidth: .infinity)
                    }
                    .tint(.red)
                    .buttonStyle(.bordered)
                }
                .padding(.top, 5)
                .padding(.horizontal)
                
                if let image = vm.cachedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                        .padding(.top, 50)
                }
                
                Spacer()
            }
            .navigationTitle("Cache Image")
        }
    }
}

struct CacheBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CacheBootcamp()
    }
}
