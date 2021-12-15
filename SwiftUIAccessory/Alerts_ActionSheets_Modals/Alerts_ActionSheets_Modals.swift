//
//  Alerts_ActionSheets_Modals.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 15/12/21.
//

import SwiftUI

struct Alerts_ActionSheets_Modals: View {
    @State private var showModalView = false
    @State private var showHalfModalView = false
    @State private var showFullScreenCover = false
    @State private var showAlertView = false
    @State private var showActionSheet = false
    
    var actionSheet: ActionSheet {
        ActionSheet(title: Text("Action Sheet's Title"), message: Text("Action Sheet's Message"), buttons: [
            .default(Text("Default Button"), action: {
                print("Default Button pressed")
            }),
            .destructive(Text("Destructive Button"), action: {
                print("Destructive Button pressed")
            }),
            .cancel()
        ])
    }
    
    var alert: Alert {
        Alert(title: Text("Alert View's Title"),
              message: Text("Alert View's Message"),
              primaryButton: .default(Text("Okay"), action: {}),
              secondaryButton: .cancel())
    }
    
    var body: some View {
        VStack {
            Button(action: {showModalView.toggle()}) {
                Text("Show Modal")
            }
            
            Button(action: {showActionSheet.toggle()}) {
                Text("Show Action Sheet")
            }
            
            Button(action: {showAlertView.toggle()}) {
                Text("Show Alert")
            }
            
            Button(action: {showFullScreenCover.toggle()}) {
                Text("Full Screen Cover")
            }
            
            Button(action: {showHalfModalView.toggle()}) {
                Text("Half Modal View")
            }
        }
        .sheet(isPresented: $showModalView) {
            ModalView()
        }
        .actionSheet(isPresented: $showActionSheet) {
            self.actionSheet
        }
        .alert(isPresented: $showAlertView) {
            alert
        }
        .fullScreenCover(isPresented: $showFullScreenCover) {
            FullScreenView()
        }
        .halfSheet(showSheet: $showHalfModalView) {
            ZStack {
                Color.red
                VStack {
                    Text("Half Sheet")
                        .font(.title.bold())
                        .foregroundColor(.white)
                    
                    Button(action: {
                        showHalfModalView.toggle()
                    }) {
                        Text("Close Sheet")
                            .foregroundColor(.white)
                    }
                    .padding()
                }
            }
            .ignoresSafeArea()
        } onEnd: {
            print("Dismissed Half Modal View")
        }
    }
}


struct ModalView: View {
    var body: some View {
        ZStack {
            Color.blue.ignoresSafeArea()
            Text("Hello, World!")
        }
    }
}

struct FullScreenView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack {
            Color.blue.opacity(0.5).ignoresSafeArea()
            VStack {
                Button(action: {presentationMode.wrappedValue.dismiss()}) {
                    Text("Close Full Screen Cover")
                }
                Text("Hello, World!")
            }
        }
    }
}

// Custom half Sheet Modifier
extension View {
    // Binding show variable
    func halfSheet<SheetView: View>(showSheet: Binding<Bool>, @ViewBuilder sheetView: @escaping ()->SheetView, onEnd: @escaping ()->())-> some View {
        return self
            .background(
                HalfSheetHelper(sheetView: sheetView(), showSheet: showSheet, onEnd: onEnd )
            )
    }
}

// UIKit Integration
struct HalfSheetHelper<SheetView: View>: UIViewControllerRepresentable {
    
    var sheetView: SheetView
    let controller = UIViewController()
    @Binding var showSheet: Bool
    var onEnd: ()->()
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        controller.view.backgroundColor = .clear
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if showSheet {
            
            // let sheetController = UIHostingController(rootView: sheetView)
            
            // presenting the half modal
            let sheetController = CustomHostingController(rootView: sheetView)
            sheetController.presentationController?.delegate = context.coordinator
            uiViewController.present(sheetController, animated: true)
        } else {
            // closing view when showsheet toggled again
            uiViewController.dismiss(animated: true)
        }
    }
    
    // On Dismiss.....
    class Coordinator: NSObject, UISheetPresentationControllerDelegate {
        var _parent: HalfSheetHelper
        
        init(parent: HalfSheetHelper) {
            self._parent = parent
        }
        func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
            _parent.showSheet = false
            _parent.onEnd()
        }
    }
}

// Custom UIHostingController for half sheet
class CustomHostingController<Content: View>: UIHostingController<Content> {
    override func viewDidLoad() {
        view.backgroundColor = .clear
        
        // setting presentation controller properties
        if let presentationController = presentationController as? UISheetPresentationController {
            presentationController.detents = [
                .medium(),
                .large()
            ]
            
            // to show grab protion...
            presentationController.prefersGrabberVisible = true
        }
    }
}

struct Alerts_ActionSheets_Modals_Previews: PreviewProvider {
    static var previews: some View {
        Alerts_ActionSheets_Modals()
    }
}
