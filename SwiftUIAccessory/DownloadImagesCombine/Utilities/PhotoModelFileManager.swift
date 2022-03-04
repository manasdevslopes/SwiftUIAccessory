//
//  PhotoModelFileManager.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 04/03/22.
//

import Foundation
import SwiftUI

class PhotoModelFileManager {
    static let instance = PhotoModelFileManager()
    let folderName = "downloaded_photos"
    
    private init() {
        createFolderIfNeeded()
    }
    
    private func createFolderIfNeeded() {
        guard let url = getFolderPath() else { return }
        
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
                print("Success creating folder")
            } catch let error {
                print("Error creating folder: \(error)")
            }
        }
    }
    
    private func getFolderPath() ->URL? {
        return FileManager
            .default
            .urls(for: .cachesDirectory,
                     in: .userDomainMask)
            .first?
            .appendingPathComponent(folderName)
    }
    
    // .../downloaded_photos
    // .../downloaded_photos/image_name.png
    private func getImagePath(key: String) -> URL? {
        guard let folder = getFolderPath() else {
            return nil
        }
        return folder.appendingPathComponent(key + ".png")
    }
    
    func add(key: String, value: UIImage) {
        guard let data = value.pngData(),
              let url = getImagePath(key: key) else {
                  return
              }
        do {
            try data.write(to: url)
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func getImage(key: String) -> UIImage? {
        guard let path = getImagePath(key: key)?.path,
              FileManager.default.fileExists(atPath: path) else {
                  return nil
              }
        return UIImage(contentsOfFile: path)
    }
}
