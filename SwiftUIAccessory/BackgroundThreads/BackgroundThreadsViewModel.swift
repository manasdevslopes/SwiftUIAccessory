//
//  BackgroundThreadsViewModel.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 19/02/22.
//

import Foundation

class BackgroundThreadsViewModel: ObservableObject {
    @Published var dataArray: [String] = []
    
    func fetchData() {
        DispatchQueue.global(qos: .background).async {
            let newData = self.downloadData()
            
            print("Thread.isMainThread 1 - \(Thread.isMainThread)")
            print("Thread.current 1 - \(Thread.current)")
            
            DispatchQueue.main.async {
                self.dataArray = newData
                print("Thread.isMainThread 2 - \(Thread.isMainThread)")
                print("Thread.current 2 - \(Thread.current)")
            }
        }
//        DispatchQueue.global().async {
//            let newData = self.downloadData()
//            DispatchQueue.main.async {
//                self.dataArray = newData
//            }
//        }
    }
    
    private func downloadData() -> [String] {
        var data: [String] = []
        
        for x in 0..<100 {
            data.append("\(x)")
            print(data)
        }
        return data
    }
}
