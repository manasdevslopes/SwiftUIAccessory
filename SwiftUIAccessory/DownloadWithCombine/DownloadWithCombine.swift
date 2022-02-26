//
//  DownloadWithCombine.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 26/02/22.
//

import SwiftUI
import Combine

struct DownloadWithCombineModel: Identifiable, Codable {
    let userID, id: Int
    let title, body: String
    
    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}

class DownloadWithCombineViewModel: ObservableObject {
    @Published var posts: [DownloadWithCombineModel] = []
    
    var cancellables = Set<AnyCancellable>()
    
    init(){
        getPosts()
    }
    
    func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        // Combine Discussion:
        /*
        // 1. sign up for monthly subscription for packaged to be delivered
        // 2. the company would make the package behind th scenes
        // 3. receive the package at your front droor
        // 4. make sure the box is not damaged
        // 5. open and make sure the item is correct
        // 6. use the item!!!!
        // 7. cancellable at any time!!
        
        // 1. Create a Publisher
        // 2. Subscribe a publisher on background thread -  this automatically done by dataTaskPublisher but we gonna do anyway by below syntax .subscribe
        // 3. recieve on main Thread
        // 4. tryMap (check that data is good)
        // 5. decode (decode data into DownloadWithCombineModel)
        // 6. sink (put the item into our app)
        // 7. store (cancel subscription if needed)
        */
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [DownloadWithCombineModel].self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case .finished:
                    print("COMPLETION: Finished")
                case .failure(let error):
                    print("There was an error: \(error.localizedDescription)")
                }
            } receiveValue: {[weak self] returnedPosts in
                self?.posts = returnedPosts
            }
            .store(in: &cancellables)
        
        // instead of .sink and recieve
        // we can use
        /*
            below .decode()
         .replaceError(with: [])
         .sink(receiveValue: {[weak self] (returnedData) in {
            self?.posts = returnedPosts
         }
         
         */
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
        response.statusCode >= 200 && response.statusCode < 300
        else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}

struct DownloadWithCombine: View {
    @StateObject var vm = DownloadWithCombineViewModel()
    
    var body: some View {
        List {
            ForEach(vm.posts) {post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

struct DownloadWithCombine_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithCombine()
    }
}
