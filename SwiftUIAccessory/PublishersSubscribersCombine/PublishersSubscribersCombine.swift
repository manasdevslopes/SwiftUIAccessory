//
//  PublishersSubscribersCombine.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 27/02/22.
//

import SwiftUI
import Combine

class PublishersSubscribersCombineViewModel: ObservableObject {
    @Published var count: Int = 0
    // var timer: AnyCancellable?
    var cancellables = Set<AnyCancellable>()
    
    @Published var textFieldText: String = ""
    @Published var textIsValid: Bool = false
    
    @Published var showButton: Bool = false
    
    init() {
        setUpTimer()
        addTextFieldSubscriber()
        addButtonSubscriber()
    }
    
    func addButtonSubscriber() {
        $textIsValid
            .combineLatest($count)
            .sink {[weak self] (isValid, count) in
                guard let self = self else { return }
                if isValid && count >= 10 {
                    self.showButton = true
                } else {
                    self.showButton = false
                }
            }
            .store(in: &cancellables)
    }
    
    func addTextFieldSubscriber() {
        $textFieldText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map { (text) -> Bool in
                print(text)
                if text.count > 3 {
                    return true
                }
                return false
            }
            // .assign(to: \.textIsValid, on: self)
            .sink(receiveValue: { [weak self] (isValid) in
                self?.textIsValid = isValid
            })
            .store(in: &cancellables)
    }
    
    func setUpTimer() {
        Timer.publish(every: 1, on: .main, in: .common).autoconnect()
            .sink { [weak self] _ in
                // self?.count += 1
                
                // if let count = self?.count, count >= 10 {
                   //  self?.timer?.cancel()
                // }
                
                guard let self = self else { return }
                self.count  += 1
                // if self.count >= 10 {
                   // for item in self.cancellables {
                   //     item.cancel()
                   // }
                // }
            }
            .store(in: &cancellables)
        
        
//        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
//            .sink { [weak self] _ in
//                // self?.count += 1
//
//                // if let count = self?.count, count >= 10 {
//                   //  self?.timer?.cancel()
//                // }
//
//                guard let self = self else { return }
//                self.count  += 1
//                if self.count >= 10 {
//                    self.timer?.cancel()
//                }
//            }
        
    }
}

struct PublishersSubscribersCombine: View {
    @StateObject var vm = PublishersSubscribersCombineViewModel()
    
    var body: some View {
        VStack {
            Text("\(vm.count)")
                .font(.largeTitle)
            
            TextField("Type something here...", text: $vm.textFieldText)
                .padding(.leading)
                .frame(height: 55)
                .font(.headline)
                .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                .cornerRadius(10)
                .overlay(
                    ZStack {
                        Image(systemName: "xmark")
                            .foregroundColor(.red)
                            .opacity(
                                vm.textFieldText.count < 1 ? 0.0 :
                                    vm.textIsValid ? 0.0 : 1.0)
                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                            .opacity(vm.textIsValid ? 1.0 : 0.0)
                    }
                        .font(.title)
                        .padding(.trailing)
                    
                    , alignment: .trailing
                )
            
            Button(action: {}) {
                Text("Submit".uppercased())
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .opacity(vm.showButton ? 1 : 0.5)
            }
            .disabled(!vm.showButton)
        }
        .padding()
    }
}

struct PublishersSubscribersCombine_Previews: PreviewProvider {
    static var previews: some View {
        PublishersSubscribersCombine()
    }
}
