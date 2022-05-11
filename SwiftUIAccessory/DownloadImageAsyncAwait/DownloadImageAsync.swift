  //
  //  DownloadImageAsync.swift
  //  SwiftUIAccessory
  //
  //  Created by MANAS VIJAYWARGIYA on 11/05/22.
  //

import SwiftUI
import Combine

class DownloadImageAsyncImageLoader {
  static let shared = DownloadImageAsyncImageLoader()
  private init() {}
  
  let url = URL(string: "https://picsum.photos/200")!
  
  func handleResponse(data: Data?, response: URLResponse?) -> UIImage? {
    guard
      let data = data,
      let image = UIImage(data: data),
      let response = response as? HTTPURLResponse,
      response.statusCode >= 200 && response.statusCode < 300  else {
      return nil
    }
    return image
  }
  
  func downloadWithEscaping(completionHandler: @escaping (_ image: UIImage?, _ error: Error?) -> ()) {
    URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
      let image = self?.handleResponse(data: data, response: response)
      completionHandler(image, error)
    }
    .resume()
  }
  
  func downloadWithCombine() -> AnyPublisher<UIImage?, Error> {
    URLSession.shared.dataTaskPublisher(for: url)
      .map(handleResponse)
      .mapError({ $0 })
      .eraseToAnyPublisher()
  }
  
  func downloadWithAsynAwait() async throws -> UIImage? {
    do {
      let (data, response) = try await URLSession.shared.data(from: url, delegate: nil)
      let image = handleResponse(data: data, response: response)
      return image
    } catch {
      throw error
    }
  }
}

class DownloadImageAsyncViewModel: ObservableObject {
  @Published var image: UIImage? = nil
  let loader = DownloadImageAsyncImageLoader.shared
  var cancellables =  Set<AnyCancellable>()
  
  func fetchImage() async {
    /* Download With Escaping Function
     loader.downloadWithEscaping {[weak self] image, error in
     DispatchQueue.main.async {
     self?.image = image
     }
     }
     */
    
    /* Download with Combine
    loader.downloadWithCombine()
      .receive(on: DispatchQueue.main)
      .sink { _ in
        
      } receiveValue: {[weak self] image in
        self?.image = image
      }
      .store(in: &cancellables)
    */
    
    // Download with Async/Await
    // function needs to be written with async to support concurrency
    let image = try? await loader.downloadWithAsynAwait()
    // MARK: - instead of DispatchQueue.main.async {}, use MainActor.run {} in Async/Await example. Actor will be covered in another video of Swiftful thinking
    await MainActor.run {
      self.image = image
    }
  }
}

struct DownloadImageAsync: View {
  @StateObject private var vm = DownloadImageAsyncViewModel()
  
  var body: some View {
    ZStack {
      if let image = vm.image {
        Image(uiImage: image)
          .resizable()
          .scaledToFit()
          .frame(width: 250, height: 250)
          .cornerRadius(25)
      } else {
        VStack {
          Image(systemName: "photo.artframe")
            .resizable()
            .scaledToFit()
            .frame(width: 250, height: 250)
          ProgressView()
        }
      }
    }
    .onAppear {
      // vm.fetchImage()
      
      // For calling async function
      Task {
        await vm.fetchImage()
      }
    }
  }
}

struct DownloadImageAsync_Previews: PreviewProvider {
  static var previews: some View {
    DownloadImageAsync()
  }
}
