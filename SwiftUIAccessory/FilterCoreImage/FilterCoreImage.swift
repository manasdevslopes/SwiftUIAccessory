//
//  FilterCoreImage.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 11/04/22.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct FilterCoreImage: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    
    @State private var showingImagePicker: Bool = false
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    @State private var showingFilterSheet: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(.secondary)
                    
                    Text("Tap to select a picture")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    image?
                        .resizable()
                        .scaledToFit()
                }
                .onTapGesture {
                    showingImagePicker = true
                }
                
                HStack {
                    Text("Intensity")
                    Slider(value: $filterIntensity)
                        .onChange(of: filterIntensity) { _ in applyProcessing() }
                }
                .padding(.vertical)
                
                HStack {
                    Button("Change Filter - \(currentFilter.name)") {
                        showingFilterSheet = true
                    }
                    Spacer()
                    Button("Save", action: save)
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Insta Filter")
            .onChange(of: inputImage) { _ in loadImage() }
            .sheet(isPresented: $showingImagePicker) {
                ImagePickers(image: $inputImage)
            }
            .confirmationDialog("Select a filter", isPresented: $showingFilterSheet) {
                Button("Crystalize") { setFilter(CIFilter.crystallize())}
                Button("Edges") { setFilter(CIFilter.edges())}
                Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur())}
                Button("Pixellate") { setFilter(CIFilter.pixellate())}
                Button("Sepia Tone") { setFilter(CIFilter.sepiaTone())}
                Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask())}
                Button("Vignette") { setFilter(CIFilter.vignette())}
                Button("Cancel", role: .cancel) { }
            }
        }
    }
    
    func loadImage() {
        // UIImage
        guard let inputImage = inputImage else { return }
        
        // Converted to CIImage
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey)
        }
        
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey)
        }
        
        // CIImage -> CGImage -> UIImage -> SwiftUI Image
        // CIImage
        guard let outputImage = currentFilter.outputImage else { return }
        
        // CGImage
        if let cgImg = context.createCGImage(outputImage, from: outputImage.extent) {
            // UIImage
            let uiImage = UIImage(cgImage: cgImg)
            // SwiftUIImage
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
    
    
    func save() {
        guard let processedImage = processedImage else { return }
        let imageSaver = ImageSaver()
        imageSaver.successHandler = {
            print("Save Finished!👍")
        }
        imageSaver.errorHandler = {
            print("Oops😵‍💫! \($0.localizedDescription)")
        }
        
        imageSaver.writeToPhotoAlbum(image: processedImage)
    }
}

struct FilterCoreImage_Previews: PreviewProvider {
    static var previews: some View {
        FilterCoreImage()
    }
}
