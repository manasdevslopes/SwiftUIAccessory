//
//  QRCodeGenerator.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 10/05/22.
// Info.plist : - Privacy - Photo Library Additions Usage Description
// This app needs permission to save images to your library.

import SwiftUI

struct QRCodeGenerator: View {
  @State private var urlInput: String = ""
  @State private var qrCode: QRCode?
  
  private let qrCodeGenerate = QRCodeGenerate()
  @StateObject private var qrCodeImageSaver = QRCodeImageSaver()
  
  var body: some View {
    NavigationView {
      GeometryReader { geo in
        VStack {
          HStack {
            TextField("Enter url:", text: $urlInput)
              .textFieldStyle(RoundedBorderTextFieldStyle())
              .textContentType(.URL)
              .keyboardType(.URL)
            
            Button("Generate") {
              UIApplication.shared.windows.first { $0.isKeyWindow }?.endEditing(true)
              qrCode = qrCodeGenerate.generateQRCode(forUrlString: urlInput)
              urlInput = ""
            }
            .disabled(urlInput.isEmpty)
            .padding(.leading)
          }
          
          Spacer()
          
          if qrCode == nil {
            EmptyStateView(width: geo.size.width)
          } else {
            if let qrCode = qrCode {
              QRCodeView(qrCode: qrCode, width: geo.size.width)
            }
          }
          
          Spacer()
        }
        .padding()
        .navigationBarTitle("QR Code")
        .navigationBarItems(trailing: Button(action: {
          // assert(qrCode != nil, "Cannot save nil QR code image")
          if let qrCode = qrCode {
            qrCodeImageSaver.saveImage(qrCode.uiImage)
          }
          
        }) { Image(systemName: "square.and.arrow.down") }
          .disabled(qrCode == nil))
        .alert(item: $qrCodeImageSaver.saveResult) { saveResult in
          return alert(forSaveStatus: saveResult.saveStatus)
        }
      }
    }
  }
  
  private func alert(forSaveStatus saveStatus: ImageSaveStatus) -> Alert {
    switch saveStatus {
      case .success:
        return Alert(
          title: Text("Success!"),
          message: Text("The QR code was saved to your photo library.")
        )
      case .error:
        return Alert(
          title: Text("Oops!"),
          message: Text("An error occurred while saving your QR code.")
        )
      case .libraryPermissionDenied:
        return Alert(
          title: Text("Oops!"),
          message: Text("This app needs permission to add photos to your library."),
          primaryButton: .cancel(Text("Ok")),
          secondaryButton: .default(Text("Open settings")) {
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
            UIApplication.shared.open(settingsUrl)
          }
        )
    }
  }
}

  // Empty View
struct EmptyStateView: View {
  let width: CGFloat
  private var imageLength: CGFloat {
    width / 2.5
  }
  
  var body: some View {
    VStack {
      Image(systemName: "qrcode")
        .resizable()
        .frame(width: imageLength, height: imageLength)
      
      Text("Create your own QR code")
        .padding(.top)
    }
    .foregroundColor(Color(UIColor.systemGray))
  }
}

  // QRCode View
struct QRCodeView: View {
  let qrCode: QRCode
  let width: CGFloat
  
  var body: some View {
    VStack {
      Label("QR code for \(qrCode.urlString)", systemImage: "qrcode.viewfinder")
        .lineLimit(3)
      Image(uiImage: qrCode.uiImage)
        .resizable()
        .frame(width: width * 2 / 3, height: width * 2 / 3)
    }
  }
}

struct QRCodeGenerator_Previews: PreviewProvider {
  static var previews: some View {
    QRCodeGenerator()
  }
}
