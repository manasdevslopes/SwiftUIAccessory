//
//  QRCodeImageSaver.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 10/05/22.
//

import Photos
import UIKit

class QRCodeImageSaver: NSObject, ObservableObject {
  @Published public var saveResult: ImageSaveResult?
  
  public func saveImage(_ image: UIImage) {
    let imageLabel = "Scan my code!"
    let photoLibraryAuthStatus = PHPhotoLibrary.authorizationStatus()
    if photoLibraryAuthStatus == .authorized {
      saveImage(image, withLabel: imageLabel)
      return
    }
    
    PHPhotoLibrary.requestAuthorization(for: .addOnly) { status in
      DispatchQueue.main.async {
        if status == .authorized {
          self.saveImage(image, withLabel: imageLabel)
          return
        }
        self.saveResult = ImageSaveResult(saveStatus: .libraryPermissionDenied)
      }
    }
  }
  
  private func saveImage(_ image: UIImage, withLabel label: String) {
    if let imageWithLabel = addLabel(label, toImage: image) {
      UIImageWriteToSavedPhotosAlbum(imageWithLabel, self, #selector(saveError), nil)
      return
    }
    // if image with label not able to create then save the image directly
    UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
  }
  
  private func addLabel(_ label: String, toImage image: UIImage) -> UIImage? {
    let font = UIFont.boldSystemFont(ofSize: 24)
    let text: NSString = NSString(string: label)
    
    // Set text font and color
    let attr = [
      NSAttributedString.Key.font: font,
      NSAttributedString.Key.foregroundColor: UIColor.systemBlue
    ]
    let textPadding: CGFloat = 8
    
    // Get Size
    let sizeOfText = text.size(withAttributes: attr)
    let heightOffset = sizeOfText.height + textPadding * 2
    let width = image.size.width
    let height = image.size.height + heightOffset
    
    UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), false, 0)
    
    if let context = UIGraphicsGetCurrentContext() {
      UIColor.white.setFill()
      let rect = CGRect(x: 0, y: 0, width: width, height: height)
      context.fill(rect)
    }
    
    // Draw Image
    image.draw(in: CGRect(x: 0, y: heightOffset, width: width, height: image.size.height))
    
    // Draw Text
    text.draw(in:
                CGRect(
                  x: (width / 2) - (sizeOfText.width / 2),
                  y: textPadding,
                  width: width,
                  height: height),
              withAttributes: attr
    )
    
    // Get new Image
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage
  }
  
  @objc private func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
    if error != nil {
      saveResult = ImageSaveResult(saveStatus: .error)
    } else {
      saveResult = ImageSaveResult(saveStatus: .success)
    }
  }
}
