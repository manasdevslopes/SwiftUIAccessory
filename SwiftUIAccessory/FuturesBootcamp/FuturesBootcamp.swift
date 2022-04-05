//
//  FuturesBootcamp.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 05/04/22.
//

import SwiftUI
import Combine

// download with Combine
// download with @escaping closure
// Convert @escaping closure to Combine

class FuturesBootcampViewModel: ObservableObject {
    @Published var title: String = "Starting Title"
    let url = URL(string: "https://www.google.com")!
    var cancellables = Set<AnyCancellable>()
    
    init() {
        download()
    }
    
    func download() {
        // getCombinePublisher()
           // .sink { _ in
                
           // } receiveValue: { [weak self] returnedValue in
           //     self?.title = returnedValue
           // }
           // .store(in: &cancellables)
        
        // getEscapingClosure { [weak self] returnedValue, error in
           // self?.title = returnedValue
        // }
        
        getFuturePublisher()
            .sink { _ in
                
            } receiveValue: { [weak self] returnedValue in
                self?.title = returnedValue
            }
            .store(in: &cancellables)
    }
    
    func getCombinePublisher() -> AnyPublisher<String, URLError> {
        URLSession.shared.dataTaskPublisher(for: url)
            .timeout(1, scheduler: DispatchQueue.main)
            .map({ _ in
                return "New Value"
            })
            .eraseToAnyPublisher()
    }
    
    func getEscapingClosure(completionHandler: @escaping (_ value: String, _ error: Error?) -> ()) {
        // below code is asynchronous code, therefore we cant return something immediately. So we used completionHandler with @escaping with returning some value in String and error in Error
        URLSession.shared.dataTask(with: url) { data, response, error in
            completionHandler("New Value 2", nil)
        }.resume()
    }
    
    func getFuturePublisher() -> Future<String, Error> {
        Future { promise in
            self.getEscapingClosure { returnedValue, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(returnedValue))
                }
            }
        }
    }
    
    func doSomething(completion: @escaping (_ value: String) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            completion("NEW STRING")
        }
    }
    
    // Never instead of Error becoz it never fails
    func doSomethingInTheFuture() -> Future<String, Never> {
        Future { promise in
            self.doSomething { value in
                promise(.success(value))
            }
        }
    }
}

struct FuturesBootcamp: View {
    @StateObject private var vm = FuturesBootcampViewModel()
    
    var body: some View {
        Text(vm.title)
    }
}

struct FuturesBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        FuturesBootcamp()
    }
}
