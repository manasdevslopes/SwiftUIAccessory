//
//  AlertTextField.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 05/04/22.
//

import SwiftUI

struct AlertTextField: View {
    @State private var title: String = ""
    
    var body: some View {
        
        VStack {
            Button(action: {
                AlertTF(title: "Login", message: "Please enter your password for @manas_iosdev", value: title, hintText: "123456", primaryTitle: "Login", secondaryTitle: "Cancel") { text in
                    print("text---->\(text)")
                    self.title = text
                } secondaryAction: {
                    print("Cancelled")
                }
            }) {
                Text("Present Alert")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
            }
            .tint(.green)
            .buttonStyle(.borderedProminent)
        }
        .padding()
        
        if title != "" {
            Text("Your id is unlocked: \(title)")
        }
    }
}

struct AlertTextField_Previews: PreviewProvider {
    static var previews: some View {
        AlertTextField()
    }
}

extension View {
    // MARK: -Alert TextField
    func AlertTF(title: String, message: String, value: String, hintText: String, primaryTitle: String, secondaryTitle: String, primaryAction: @escaping (String) -> (), secondaryAction: @escaping () -> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField { field in
            field.placeholder = hintText
            field.text = value
        }
        alert.addAction(.init(title: secondaryTitle, style: .cancel, handler: { _ in
            secondaryAction()
        }))
        
        alert.addAction(.init(title: primaryTitle, style: .default, handler: { _ in
            if let text = alert.textFields?[0].text {
                primaryAction(text)
            } else {
                primaryAction("")
            }
        }))
        
        // MARK: - Presenting Alert
        rootController().present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Root View Controller
    func rootController() -> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        
        return root
    }
    
}
