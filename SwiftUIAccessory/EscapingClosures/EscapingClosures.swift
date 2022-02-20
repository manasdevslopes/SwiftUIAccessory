//
//  EscapingClosures.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 20/02/22.
//

import SwiftUI

class EscapingClosuresViewModel: ObservableObject {
    @Published var text: String = "Hello"
    
    func getData() {
        // This is direct return of the data from function so we can assign it to the variable
        // let newData = downloadData()
        // text = newData
        
        // But for completion handler we can't directly assign it to a variable
        // downloadData2 { (returnedData) in
           // text = returnedData
        // }
        
        // when used @escaping, then use self here But this is having strong connection with the class ,so also use weak self
        // downloadData3 { [weak self] (returnedData) in
           // self?.text = returnedData
        // }
        
        // downloadData4 { [weak self] (downloadResult) in
           // self?.text = downloadResult.data
        // }
        
        downloadData5 { [weak self] (downloadResult) in
            self?.text = downloadResult.data
        }
    }
    
    // This is synchronous code "-> String", means immediately return string
    func downloadData() -> String {
        return "New Data!"
    }
    
    // When data goes to the internet and come back and get downloaded means it will take time. So we can't directly return this by using "-> String". In that case, "@escaping" closure comes into the picture
    // inside func name(completionHandler: (_ data: String) -> Void OR -> ()) {}
    func downloadData2(completionHandler: (_ data: String) -> Void) {
        completionHandler("New Data!")
    }
    
    // Or, when inner things of func is having some deleys by using DispatchQueue , it will give error - "Escaping closure captures non-escaping parameter 'completionHandler'".
    // So use "@escaping"
    func downloadData3(completionHandler: @escaping (_ data: String) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completionHandler("New Data!")
        }
    }
    
    // More readable code
    func downloadData4(completionHandler: @escaping (DownloadResult) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let result = DownloadResult(data: "New Data!")
            completionHandler(result)
        }
    }
    
    // One more last
    func downloadData5(completionHandler: @escaping DownloadCompletion) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let result = DownloadResult(data: "New Data!")
            completionHandler(result)
        }
    }
}

struct DownloadResult {
    let data: String
}

typealias DownloadCompletion = (DownloadResult) -> ()

struct EscapingClosures: View {
    @StateObject var vm = EscapingClosuresViewModel()
    
    var body: some View {
        Text(vm.text)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(.blue)
            .onTapGesture {
                vm.getData()
            }
    }
}

struct EscapingClosures_Previews: PreviewProvider {
    static var previews: some View {
        EscapingClosures()
    }
}
