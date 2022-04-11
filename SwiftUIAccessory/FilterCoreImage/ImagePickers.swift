//
//  ImagePickers.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 11/04/22.
//

import PhotosUI
import SwiftUI

struct ImagePickers: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: ImagePickers
        init(_ parent: ImagePickers) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            guard let provider = results.first?.itemProvider else { return }
            
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    self.parent.image = image as? UIImage
                }
            }
            
        }
        
        
    }
    
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    typealias UIViewControllerType = PHPickerViewController
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
}
