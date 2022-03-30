//
//  AdvancedCombine.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 29/03/22.
//

import SwiftUI
import Combine

class AdvancedCombineDataService {
    // @Published var basicPublisher: String = ""
    // let currentValuePublisher = CurrentValueSubject<String, Never>("first publish")
    let passThroughPublisher = PassthroughSubject<Int, Error>()
    // let passThroughPublisher = PassthroughSubject<Int?, Error>()
    
    let boolPublisher = PassthroughSubject<Bool, Error>()
    let intPublisher = PassthroughSubject<Int, Error>()
    
    init() {
        publishFakeData()
    }
    
    private func publishFakeData() {
        let items: [Int] = Array(0..<11)
        // let items: [Int] = Array(1..<11)
        // let items: [Int] = [0,1,2,3,4,4,5,6,7,7,8,9,10]
        // let items: [Int?] = [0,1,nil,3,4,5,6,7,8,9,10]
        
        for x in items.indices {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(x)) {
                // self.currentValuePublisher.send(items[x])
                self.passThroughPublisher.send(items[x])
                // self.basicPublisher = items[x]

                if (x > 4 && x < 8) {
                    self.boolPublisher.send(true)
                    self.intPublisher.send(999)
                } else {
                    self.boolPublisher.send(false)
                }
                
                if x == items.indices.last {
                    self.passThroughPublisher.send(completion: .finished)
                }
            }
        }
        // DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
           // self.passThroughPublisher.send(1)
        // }
        // DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
           // self.passThroughPublisher.send(2)
        // }
        // DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
           // self.passThroughPublisher.send(3)
        // }
        
    }
}

class AdvancedCombineViewModel: ObservableObject {
    @Published var data: [String] = []
    let dataService = AdvancedCombineDataService()
    
    var cancellables = Set<AnyCancellable>()
    
    @Published var error: String = ""
    
    
    @Published var dataBools: [Bool] = []
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        // dataService.$basicPublisher
        // dataService.currentValuePublisher
        // dataService.passThroughPublisher
            // MARK: - Sequence Operations
            /*
            // .first()
            // .first(where: { $0 > 4 })
            /*.tryFirst(where: { int in
                if (int == 3) {
                    throw URLError(.badServerResponse)
                }
                return int > 1
            })*/
            // .last()
            // .last(where: { $0 > 9 })
            /*.tryLast(where: { int in
                if (int == 13) {
                    throw URLError(.badServerResponse)
                }
                return int > 1
            })*/
            // .dropFirst()
            // .dropFirst(4)
            // .drop(while: { $0 < 4 })
            /*.tryDrop(while: { int in
                if (int == 17) {
                    throw URLError(.badServerResponse)
                }
                return int < 6
            })*/
            // .prefix(5)
            // .prefix(while: { $0 < 5 })
            // .tryPrefix(while: {})
            // .output(at: 1)
            //.output(in: 2..<4)
        */
        
            // MARK: - Mathematic Operations
            /*
            // .max()
            // .max(by: { int1, int2 in
               // return int1 < int2
            // })
            // .tryMax(by: {})
            // .min()
            // .min(by: { int1, int2 in
               // return int1 < int2
            // })
            // .tryMin(by: )
            */
            
            // MARK: - Filtering / Reducing Operations
            /*
            // .map({ String($0) })
            // .tryMap({ int in
              //  if int == 5 {
                //    throw URLError(.badServerResponse)
              //  }
              //  return String(int)
            // })
            // .compactMap({ int in
               // if int == 5 {
                 //   return nil
               // }
               // return "\(int)" // String(int)
            // })
            // .tryCompactMap()
            // .filter({ ($0 > 3) && ($0 < 7) })
            // .tryFilter()
            // .removeDuplicates()
            // .removeDuplicates(by: { int1, int2 in
               // return int1 == int2
            // })
            // .tryRemoveDuplicates(by: )
            // .replaceNil(with: 5)
            // .replaceEmpty(with: 5)
            // .replaceError(with: "DEFAULT VALUE")
            // .scan(0, { existingValue, newValue in
               // return existingValue + newValue
            // })
            // .scan(0, { $0 + $1 })
            // .scan(0, +)
            // .tryScan( , )
            // .reduce(0, { existingValue, newValue in
               // return existingValue + newValue
            // })
            // .reduce(0, { $0 + $1 })
            // .reduce(0, +)
            // .collect() // this is used after .map and it will give it in an array so in .sink recieveValue directly pass it to published no need to append
            // .collect(3) // same way to use and in .sink recieveValue write self?..data.append(contentsOf: returnedValue)
            // .allSatisfy({ $0 < 50  })
            // .tryAllSatisfy()
            */
        
            // MARK: - Timing Operation
            /*
            // .debounce(for: 0.75, scheduler: DispatchQueue.main)
            // .delay(for: 2, scheduler: DispatchQueue.main)
            // .measureInterval(using: DispatchQueue.main)
            // .map({ stride in
               // return "\(stride.timeInterval)"
            // })  // For measureInterval .map is required to convert stride to required type
            // .throttle(for: 5, scheduler: DispatchQueue.main, latest: true)
            // .retry(3)
            // .timeout(0.75, scheduler: DispatchQueue.main)
            */
        
            // MARK: - Multiple Publishers & Subscribers
            /*
            // .combineLatest(dataService.boolPublisher)
            // .compactMap({ int, bool in
               // if bool {
                 //   return String(int)
               // }
               // return nil
            // })
            // .compactMap({ $1 ? String($0) : "n/a" })
            // .combineLatest(dataService.boolPublisher, dataService.intPublisher)
            // .compactMap({ int1, bool, int2 in
               // if bool {
               //     return String(int1)
               // }
               // return "n/a"
            // })
            // .merge(with: dataService.intPublisher)
            // .zip(dataService.boolPublisher) // As zip will give combined value in tuple
            // .zip(dataService.boolPublisher, dataService.intPublisher)
            // .map({ tuple in
               // return String(tuple.0) + "-" + tuple.1.description + "-" + String(tuple.2)
            // })
            // .tryMap({ int in
               // if int == 5 {
               //     throw URLError(.badServerResponse)
               // }
               // return int
            // })
            // .catch({ error in
               // self.dataService.intPublisher
            // })
            */
        
        
        let sharedPublisher = dataService.passThroughPublisher
            // .dropFirst(3)
            .share()
            // .multicast {
               // PassthroughSubject<Int, Error>()
            // }
        
        sharedPublisher
            .map({ String($0) })
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.error = "Error: \(error.localizedDescription)"
                }
            } receiveValue: { [weak self] returnedValue in
                self?.data.append(returnedValue)
            }
            .store(in: &cancellables)

    
        // One more subscriber to update array of Bool publisher so that it can be used somewhere else in other screen views or viewmodels
        sharedPublisher
            .map({ $0 > 5 ? true :  false })
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.error = "Error: \(error.localizedDescription)"
                }
            } receiveValue: { [weak self] returnedValue in
                self?.dataBools.append(returnedValue)
            }
            .store(in: &cancellables)

       // DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
         //   sharedPublisher
         //       .connect()
         //       .store(in: &self.cancellables)
       // }
    }
    
}

struct AdvancedCombine: View {
    @StateObject private var vm = AdvancedCombineViewModel()
    
    var body: some View {
        ScrollView {
            HStack {
                VStack {
                    ForEach(vm.data, id: \.self) {item in
                        Text(item)
                            .font(.largeTitle)
                            .fontWeight(.black)
                    }
                    if !vm.error.isEmpty {
                        Text(vm.error)
                    }
                }
                VStack {
                    ForEach(vm.dataBools, id: \.self) {item in
                        Text(item.description)
                            .font(.largeTitle)
                            .fontWeight(.black)
                    }
                }
            }
        }
    }
}

struct AdvancedCombine_Previews: PreviewProvider {
    static var previews: some View {
        AdvancedCombine()
    }
}
