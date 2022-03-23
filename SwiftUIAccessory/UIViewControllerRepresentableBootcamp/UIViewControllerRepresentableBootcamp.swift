//
//  UIViewControllerRepresentableBootcamp.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 23/03/22.
//

import SwiftUI

struct UIViewControllerRepresentableBootcamp: View {
    @State private var showScreen: Bool = false
    @State private var image: UIImage? = nil
    
    var body: some View {
        VStack {
            Text("Hi")
            
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .cornerRadius(50)
            }
            Button(action: {showScreen.toggle()}) {
                Text("Click here...")
            }
            .sheet(isPresented: $showScreen) {
                // BasicUIViewControllerRepresentable(labelText: "hello World!🤙")
                UIImagePickerControllerRepresentable(image: $image, showScreen: $showScreen)
                    .ignoresSafeArea()
            }
        }
    }
}

struct UIViewControllerRepresentableBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        UIViewControllerRepresentableBootcamp()
    }
}

// Image Picker in UIKit
struct UIImagePickerControllerRepresentable : UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Binding var showScreen: Bool
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let vc = UIImagePickerController()
        vc.allowsEditing = false
        vc.delegate = context.coordinator
        return vc
    }
    
    // Send data from SwiftUI to UIKit
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    // Send Data from UIKit to SwiftUI
    func makeCoordinator() -> Coordinator {
        return Coordinator(image: $image, showScreen: $showScreen)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        @Binding var image: UIImage?
        @Binding var showScreen: Bool
        
        init(image: Binding<UIImage?>, showScreen: Binding<Bool>) {
            self._image = image
            self._showScreen = showScreen
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let newImage = info[.originalImage] as? UIImage else { return }
            image = newImage
            showScreen = false
        }
    }
}


struct BasicUIViewControllerRepresentable: UIViewControllerRepresentable {
    let labelText: String
    
    func makeUIViewController(context: Context) -> some UIViewController {
        // let vc = UIViewController()
        // vc.view.backgroundColor = .blue
        
        // let label = UILabel()
        // label.text = labelText
        // label.textColor = UIColor.white
        
        // vc.view.addSubview(label)
        // label.frame = vc.view.frame
        
        // return vc
        let vc = MyFirstViewController()
        vc.labelText = labelText
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

class MyFirstViewController: UIViewController {
    var labelText: String = "Starting value"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        
        let label = UILabel()
        label.text = labelText
        label.textColor = UIColor.white
        
        view.addSubview(label)
        label.frame = view.frame
    }
}
