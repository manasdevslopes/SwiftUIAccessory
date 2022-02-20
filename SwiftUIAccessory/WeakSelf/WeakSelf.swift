//
//  WeakSelf.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 20/02/22.
//

import SwiftUI

struct WeakSelf: View {
    @AppStorage("count") var count: Int?
    
    init() {
        count = 0
    }
    
    var body: some View {
        NavigationView {
            NavigationLink("Navigate", destination: WeakSelfSecondScreen())
                .navigationTitle("Screen 1")
        }
        .overlay(
            Text("\(count ?? 0)")
                .font(.largeTitle)
                .padding()
                .background(Color.green.cornerRadius(10))
            ,
            alignment: .topTrailing
        )
    }
}

struct WeakSelfSecondScreen: View {
    @StateObject var vm = WeakSelfSecondScreenViewModel()
    
    var body: some View {
        VStack {
            Text("Second View")
                .font(.largeTitle)
            .foregroundColor(.red)
            
            if let data = vm.data {
                Text(data)
            }
        }
    }
}

class WeakSelfSecondScreenViewModel: ObservableObject {
    @Published var data: String? = nil
    
    init() {
        print("Initilize Now")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount + 1, forKey: "count")
        getData()
    }
    
    deinit {
        print("DEINITILIZE NOW")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount - 1, forKey: "count")
    }
    
    func getData() {
        // DispatchQueue.global().async {
            // By putting "self" , it is man=king strong connection with the class.
            // self.data =  "NEW DATA"
        // }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 500) { [weak self] in
            // due to long time taking while loading data and due to strong reference with class by writing "self", and when the user go to the second screen and immediately come back to first screen without loading data, then deinitialize is not called and when the user again go to the second screen, that time initialize again but first time initialized never got deinitialized. So for this we need to use "[weak self] in" and make below self as optional "?".
            self?.data =  "NEW DATA"
        }
    }
}

struct WeakSelf_Previews: PreviewProvider {
    static var previews: some View {
        WeakSelf()
    }
}
