//
//  BackgroundThreads.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 19/02/22.
//

import SwiftUI

struct BackgroundThreads: View {
    @StateObject var vm = BackgroundThreadsViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                Text("Load Data...")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .onTapGesture {
                        vm.fetchData()
                    }
                ForEach(vm.dataArray, id: \.self) {
                    Text($0)
                        .font(.headline)
                        .foregroundColor(.red)
                }
            }
        }
    }
}

struct BackgroundThreads_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundThreads()
    }
}
