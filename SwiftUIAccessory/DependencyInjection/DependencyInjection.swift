//
//  DependencyInjection.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 24/03/22.
//

import SwiftUI
import Combine

// PROBLEMS with SINGLETONS
// 1. SINGLETONS are global
// 2. Can't customize the init!
// 3. Can't swap out dependencies

struct PostModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

// 3. problem solved by using protocol
protocol DataServiceProtocol {
    func getData() -> AnyPublisher<[PostModel], Error>
}


class ProductionDataService: DataServiceProtocol {
    // 1. problem
    // static let instance = ProductionDataService()
    // private init() {}
    
    // 2. Problem
    let url: URL
    // 2. problem solved - customize init
    init(url: URL) {
        self.url = url
    }
    
    func getData() -> AnyPublisher<[PostModel], Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map({ $0.data })
            .decode(type: [PostModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

class MockDataService: DataServiceProtocol {
    // 3. problem, if there are multiple services like dev, test, stage, production etc...

    let testData: [PostModel]
    
    init(data: [PostModel]?) {
        self.testData = data ?? [
            PostModel(userId: 1, id: 1, title: "One", body: "one"),
            PostModel(userId: 2, id: 2, title: "Two", body: "two"),
            PostModel(userId: 3, id: 3, title: "Three", body: "three"),
            PostModel(userId: 4, id: 4, title: "Four", body: "four"),
            PostModel(userId: 5, id: 5, title: "Five", body: "five")
        ]
    }
    
    func getData() -> AnyPublisher<[PostModel], Error> {
        Just(testData)
            .tryMap({ $0 })
            .eraseToAnyPublisher()
    }
}


class DependencyInjectionViewModel: ObservableObject {
    @Published var dataArray: [PostModel] = []
    var cancellables = Set<AnyCancellable>()
    
    let dataService: DataServiceProtocol
    // MARK: - 1. problem solved - This is Dependency Injection
    init(dataService: DataServiceProtocol) {
        self.dataService = dataService
        loadPosts()
    }
    
    private func loadPosts() {
        // ProductionDataService.instance.getData()
        dataService.getData()
            .sink { _ in
                
            } receiveValue: { [weak self] returnedPosts in
                self?.dataArray = returnedPosts
            }
            .store(in: &cancellables)
    }
}

struct DependencyInjection: View {
    @StateObject private var vm: DependencyInjectionViewModel
    
    init(dataService: DataServiceProtocol) {
        _vm = StateObject(wrappedValue: DependencyInjectionViewModel(dataService: dataService))
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(vm.dataArray) {post in
                    Text(post.title)
                }
            }
        }
    }
}

struct DependencyInjection_Previews: PreviewProvider {
    // static let dataService = ProductionDataService(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!)
    
     static let dataService = MockDataService(data: nil)
//    static let dataService = MockDataService(data: [
//            PostModel(userId: 1, id: 1, title: "One", body: "one"),
//            PostModel(userId: 2, id: 2, title: "Two", body: "two"),
//    ])
    
    static var previews: some View {
        DependencyInjection(dataService: dataService)
    }
}
