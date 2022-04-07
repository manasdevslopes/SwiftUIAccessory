//
//  CustomColorPicker.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 07/04/22.
//

import SwiftUI
import PhotosUI

// MARK: Extension to call Image Color Picker
extension View {
    func imageColorPicker(showPicker: Binding<Bool>, color: Binding<Color>) -> some View {
        return self
            .fullScreenCover(isPresented: showPicker) {
                Helper(showPicker: showPicker, color: color)
            }
    }
}

// MARK: Custom View for color picker
struct Helper: View {
    @Binding var showPicker: Bool
    @Binding var color: Color
    
    @State var showImagePicker: Bool = false
    @State var imageData: Data = .init(count: 0)
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                // MARK: Image Picker View
                GeometryReader { geo in
                    let size = geo.size
                    
                    VStack(spacing: 12) {
                        if let image = UIImage(data: imageData) {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: size.width, height: size.height)
                            
                        } else {
                            Image(systemName: "plus")
                                .font(.system(size: 35))
                            
                            Text("Tap to add Image")
                                .font(.system(size: 14, weight: .light))
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        // show Image Picker
                        showImagePicker.toggle()
                    }
                }
                
                ZStack(alignment: .top) {
                    // Display the selected color
                    Rectangle()
                        .fill(color)
                        .frame(height: 90)
                    
                    CustomColorPicker(color: $color)
                        .frame(width: 100, height: 50, alignment: .topLeading)
                        .clipped()
                        .offset(x: 20)
                }
            }
            .ignoresSafeArea(.container, edges: .bottom)
            .navigationTitle("Image Color Picker")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Close") {
                    showPicker.toggle()
                }
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(showPicker: $showImagePicker, imageData: $imageData)
            }
        }
    }
}

// MARK: Image Picker
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var showPicker: Bool
    @Binding var imageData: Data
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            if let first = results.first {
                first.itemProvider.loadObject(ofClass: UIImage.self) {[self] result, error in
                    guard let image = result as? UIImage else {
                        parent.showPicker.toggle()
                        return
                    }
                    parent.imageData = image.jpegData(compressionQuality: 1) ?? .init(count: 0)
                    
                    // Closing Picker
                    parent.showPicker.toggle()
                }
            } else {
                parent.showPicker.toggle()
            }
        }
        
    }
}



// MARK: Custom Color pIcker with the help of UIColorPicker
struct CustomColorPicker: UIViewControllerRepresentable {
    @Binding var color: Color
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIColorPickerViewController {
        let picker = UIColorPickerViewController()
        picker.supportsAlpha = false
        picker.selectedColor = UIColor(color)
        
        // Connecting Delegate
        picker.delegate = context.coordinator
        
        // removing title
        picker.title = ""
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIColorPickerViewController, context: Context) {
        // Changing Tint color
        uiViewController.view.tintColor = (color.isDarkColor ? .white : .black)
    }
    
    // MARK: Delegate Methods
    class Coordinator: NSObject, UIColorPickerViewControllerDelegate {
        var parent: CustomColorPicker
        
        init(parent: CustomColorPicker) {
            self.parent = parent
        }
        
        func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
            // Updating color
            parent.color = Color(viewController.selectedColor)
        }
        
        func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
            parent.color = Color(color)
        }
    }
}


// MARK: Simple extension to find the color is light or dark
extension Color {
    var isDarkColor: Bool {
        return UIColor(self).isDarkColor
    }
}

extension UIColor {
    var isDarkColor: Bool {
        var (r, g, b, a): (CGFloat, CGFloat, CGFloat, CGFloat) = (0,0,0,0)
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        let lum = 0.2126 * r + 0.7152 * g + 0.0722 * b
        return lum < 0.50
    }
}
