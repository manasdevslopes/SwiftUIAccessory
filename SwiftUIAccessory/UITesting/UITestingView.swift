//
//  UITestingView.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 27/03/22.
//

import SwiftUI

class UITestingViewModel: ObservableObject {
    let placeholderText: String = "Add your name..."
    @Published var textFieldText: String = ""
    @Published var currentUserSignedIn: Bool
    
    init(currentUserSignedIn: Bool) {
        self.currentUserSignedIn = currentUserSignedIn
    }
    
    func signUpButtonPressed() {
        guard !textFieldText.isEmpty else { return }
        currentUserSignedIn = true
    }
    
}

struct UITestingView: View {
    @StateObject private var vm: UITestingViewModel
    
    init(currentUserSignedIn: Bool) {
        _vm = StateObject(wrappedValue: UITestingViewModel(currentUserSignedIn: currentUserSignedIn))
    }
    
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            ZStack {
                if vm.currentUserSignedIn {
                    SignedInHomeView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .transition(.move(edge: .trailing))
                }
                if !vm.currentUserSignedIn {
                    signUpLayer
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .transition(.move(edge: .leading))
                }
            }
        }
    }
}

struct UITestingView_Previews: PreviewProvider {
    static var previews: some View {
        UITestingView(currentUserSignedIn: true)
    }
}

extension UITestingView {
    private var signUpLayer: some View {
        VStack {
            TextField(vm.placeholderText, text: $vm.textFieldText)
                .foregroundColor(Color.primary)
                .font(.headline)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .shadow(color: Color.white.opacity(0.15), radius: 10, x: 0, y: 0)
                )
                .accessibilityIdentifier("SinUpTextField")
            
            Button(action: {
                withAnimation(.spring()) {
                    vm.signUpButtonPressed()
                }
            }) {
                Text("Sign Up!")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(Color.blue )
                    .cornerRadius(10)
            }
            .accessibilityIdentifier("SinUpButton")
        }
        .padding()
    }
}

struct SignedInHomeView: View {
    @State private var showAlert: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Button(action: {
                    showAlert.toggle()
                }) {
                    Label("Show Welcome Alert!", systemImage: "checkmark.diamond")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
                .controlSize(.large)
                .accessibilityIdentifier("ShowAlertButton")
                .alert("Welcome to the App!", isPresented: $showAlert) {
                    Button("Ok", role: .cancel) { }
                    .accessibilityIdentifier("AlertOkButton")
                }
                // .accessibilityIdentifier("welcomeAlert")
                
                NavigationLink(destination: Text("Destination")) {
                    Text("Destination")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .accessibilityIdentifier("NavigationLinkToDestination")
            }
            .padding()
            .navigationTitle("Welcome")
        }
    }
}
