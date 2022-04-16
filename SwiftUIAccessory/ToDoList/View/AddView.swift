//
//  AddView.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 16/04/22.
//

import SwiftUI
import AwesomeToast

struct AddView: View {
    @EnvironmentObject var listVM: ListViewModel
    @Environment(\.dismiss) var dismissMode
    @StateObject var hapticVM = HapticViewModel()
    @State var textFieldText: String = ""
    @State var showAlert = false
    
    var body: some View {
        ZStack {
            Color(hex: "#E5E3D5").ignoresSafeArea()
            
            ScrollView {
                VStack {
                    TextField("Type something here...", text: $textFieldText)
                        .padding(.horizontal)
                        .frame(height: 55)
                        .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        .cornerRadius(10)
                    
                    Button(action: {
                        hapticVM.impact(style: .soft)
                        hapticVM.haptic(type: .success)
                        self.saveButtonPressed()
                    }) {
                        Text("Save".uppercased())
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.blue)
                    }
                    .tint(.blue)
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.roundedRectangle(radius: 10))
                    .controlSize(.large)
                }
                .padding(14)
            }
        }
        .navigationTitle("Add an Item 🖊")
        .showToast(title: "Item must be 3 characters or more! 😱", isPresented: $showAlert, color: Color(#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)), duration: 4, alignment: .top, toastType: .offsetToast)
    }
    
    func saveButtonPressed() {
        if textIsAppropriate() {
            listVM.addItem(title: textFieldText)
            dismissMode()
        }
    }
    
    func textIsAppropriate() -> Bool {
        if textFieldText.count < 3 {
            showAlert.toggle()
            return false
        }
        return true
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView().environmentObject(ListViewModel())
    }
}
