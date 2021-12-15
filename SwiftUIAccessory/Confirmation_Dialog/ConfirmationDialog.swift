//
//  ConfirmationDialog.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 15/12/21.
//

import SwiftUI

struct ConfirmationDialog: View {
    @State private var isShowingAlert = false
    @State private var isShowingConfimationDialog = false
    
    var body: some View {
        VStack {
            Button(action: {
                isShowingAlert = true
            }) {
                Label("Delete via Alert", systemImage: "trash.fill")
            }
            .buttonStyle(.bordered)
            .tint(.pink)
            .controlSize(.large)
            .alert("Are you sure?", isPresented: $isShowingAlert) {
                Button("Delete", role: .destructive) { print("Items Deleted")}
            }
            
            Button(action: {
                isShowingConfimationDialog = true
            }) {
                Label("Delete via confimation dialog", systemImage: "trash.fill")
            }
            .buttonStyle(.bordered)
            .tint(.pink)
            .controlSize(.large)
            .confirmationDialog("Are you sure?", isPresented: $isShowingConfimationDialog, titleVisibility: .visible) {
                Button("Delete", role: .destructive) { print("Items Deleted")}
            }
        }
    }
}

struct ConfirmationDialog_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ConfirmationDialog()
                .preferredColorScheme(.dark)
            
            ConfirmationDialog()
                .previewDevice("iPad Air (4th generation)")
                .preferredColorScheme(.dark)
        }
    }
}
