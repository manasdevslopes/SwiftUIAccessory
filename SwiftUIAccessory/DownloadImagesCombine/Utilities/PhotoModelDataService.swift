//
//  PhotoModelDataService.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 04/03/22.
//

import Foundation
import Combine

class PhotoModelDataService {
    // Singleton
    static let instance = PhotoModelDataService()
    @Published var photoModels: [PhotoModel] = []
    
    var cancellables = Set<AnyCancellable>()
    
    private init() {
        downloadData()
    }
    
    
    // Combine Framework
    // URLSession.shared.dataTaskPublisher
    // decode
    
    func downloadData() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [PhotoModel].self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case .finished:
                    print("COMPLETION: Finished")
                    break
                case .failure(let error):
                    print("Error downloading data: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] returnedPhotoModels in
                self?.photoModels = returnedPhotoModels
            }
            .store(in: &cancellables)

    }
    
    private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
                             response.statusCode >= 200 && response.statusCode < 300
        else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}
