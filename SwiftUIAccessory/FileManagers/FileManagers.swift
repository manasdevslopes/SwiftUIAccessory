//
//  FileManagers.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 01/03/22.
//

import SwiftUI

class LocalFileManager {
    // Singleton
    static let instance = LocalFileManager()
    let folderName = "MyApp_Images"
    
    init() {
        createFolderIfNeeded()
    }
    
    func createFolderIfNeeded() {
        guard let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent(folderName).path else {
            return
        }
        
        if !FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
                print("Success creating folder")
            } catch let error {
                print("Error creating folder: \(error)")
            }
        }
    }
    
    func deleteFolder() {
        guard let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent(folderName).path else {
            return
        }
        
        do {
            try FileManager.default.removeItem(atPath: path)
            print("Success Deleting Folder")
        } catch let error {
            print("Error Deleting Folder: \(error)")
        }
    }
    func saveImage(image: UIImage, name: String) -> String{
        createFolderIfNeeded()
        // image.pngData()
        guard let data = image.jpegData(compressionQuality: 1.0),
              let path = getImageForAPath(name: name)
        else {
            return "Error getting data"
        }
        
        // Go through the web page - iOS Data Storage Guidelines save in Bookmarks in SwiftUI folder
        // 1. First type
        // let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        // 2. Second Type
        // let directory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        // .first is used becoz directory prints out in an array
        
        // 3. Third type
        // let directory3 = FileManager.default.temporaryDirectory
        
        // let path = directory?.appendingPathComponent("\(name).jpg")
        
        
        
        do {
            try data.write(to: path)
            print("Path ------->", path)
            return "Success Saving!"
        } catch let error {
            print("Error: \(error.localizedDescription)")
            return "Error saving image \(error)"
        }
    }
    
    func getImage(name: String) -> UIImage? {
        guard let path = getImageForAPath(name: name)?.path,
        FileManager.default.fileExists(atPath: path) else {
            print("Error getting path")
            return nil
        }
        
        return UIImage(contentsOfFile: path)
    }
    
    func deleteImage(name: String) -> String {
        guard let path = getImageForAPath(name: name)?.path,
              FileManager.default.fileExists(atPath: path) else {
            return "Error getting path"
        }
        
        do {
            try FileManager.default.removeItem(atPath: path)
            return  "Successully deleted!"
        } catch let error {
            return "Error: Deleting image from file manager \(error.localizedDescription)"
        }
    }
    
    func getImageForAPath(name: String) -> URL? {
        // .first is used becoz directory prints out in an array
        guard let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?
                .appendingPathComponent(folderName)
                .appendingPathComponent("\(name).jpg")
        else {
            print("Error getting path.")
            return nil
        }
        
        return path
    }
}

class FileManagersViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    let imageName: String = "Manas"
    
    let manager = LocalFileManager.instance
    
    @Published var image2: UIImage? = nil
    
    @Published var infoMsg: String = ""
    
    init() {
        getImageFromAssetsFolder()
    }
    
    func getImageFromAssetsFolder() {
        image = UIImage(named: imageName)
    }
    
    func saveImage() {
        guard let image = image else { return }
        infoMsg = manager.saveImage(image: image, name: imageName)
    }
    
    func getImageFromFileManager() {
        if let image =  manager.getImage(name: imageName) {
            image2 = image
            infoMsg = "Get Image success"
        } else {
            infoMsg = "ImagePath not found"
        }
    }
    
    func deleteImage() {
        let imageDeleted = manager.deleteImage(name: imageName)
        manager.deleteFolder()
        print("imageDeleted: \(imageDeleted)")
        if imageDeleted == "Successully deleted!" {
            image2 = nil
        }
        infoMsg = imageDeleted
    }
}

struct FileManagers: View {
    @StateObject var vm = FileManagersViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if let image = vm.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                }
                
                Button(action: {
                    vm.saveImage()
                }) {
                    Text("Save to FM")
                        .frame(maxWidth: .infinity)
                }
                .tint(.green)
                .buttonStyle(.bordered)
                .padding(.horizontal)
                .padding(.top, 40)
                
                Spacer()
                
                if let image2 = vm.image2 {
                    Image(uiImage: image2)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                }
                
                Button(action: {
                    vm.getImageFromFileManager()
                }) {
                    Text("Get From FM")
                        .frame(maxWidth: .infinity)
                }
                .tint(.blue)
                .buttonStyle(.bordered)
                .padding(.horizontal)
                .padding(.top, 40)
                
                
                Text(vm.infoMsg)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.purple)
                
                
                Button(action: {
                    vm.deleteImage()
                }) {
                    Text("Delete Image From FM")
                        .frame(maxWidth: .infinity)
                }
                .tint(.red)
                .buttonStyle(.bordered)
                .padding(.horizontal)
            }
            .navigationTitle("File Manager")
        }
    }
}

struct FileManagers_Previews: PreviewProvider {
    static var previews: some View {
        FileManagers()
    }
}
