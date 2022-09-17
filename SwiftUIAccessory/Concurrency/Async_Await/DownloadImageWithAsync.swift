  //
  //  DownloadimageWithAsync.swift
  //  SwiftUIAccessory
  //
  //  Created by MANAS VIJAYWARGIYA on 17/09/22.
  //

import SwiftUI
import Combine

class DownloadImageWithAsyncLoader {
  
  let url = URL(string: "https://picsum.photos/200/300")!
  
  func handleResponse(data: Data?, response: URLResponse?) -> UIImage? {
    guard
      let data = data,
      let image = UIImage(data: data),
      let response = response as? HTTPURLResponse,
      response.statusCode >= 200 && response.statusCode < 300 else {
      return nil
    }
    return image
  }
  
  func downloadImageWithEscaping(completionHandler: @escaping (_ image: UIImage?, _ error: Error?) -> ()) {
    URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
      let image = self?.handleResponse(data: data, response: response)
      completionHandler(image, error)
    }.resume()
  }
  
  func downloadImageWithCombine() -> AnyPublisher<UIImage?, Error> {
    URLSession.shared.dataTaskPublisher(for: url)
      .map(handleResponse)
      .mapError({ $0 })
      .eraseToAnyPublisher()
  }
  
  func downloadImageWithAsync() async throws -> UIImage? {
    do {
      let (data, response) = try await URLSession.shared.data(from: url, delegate: nil)
      let image = handleResponse(data: data, response: response)
      return image
    } catch {
      throw error
    }
  }
}

class DownloadImageWithAsyncViewModel: ObservableObject {
  let loader = DownloadImageWithAsyncLoader()
  
  @Published var image: UIImage? = nil
  var cancellables =  Set<AnyCancellable>()
  
  func fetchImage() async {
    /* Download With Escaping Function
     loader.downloadImageWithEscaping {[weak self] image, error in
     //    if let image {
     DispatchQueue.main.async {
     self?.image = image
     }
     //    }
     }
     */
    
    /* Download with Combine
    loader.downloadImageWithCombine()
      .receive(on: DispatchQueue.main)
      .sink { _ in
      } receiveValue: { [weak self] image in
        self?.image = image
      }
      .store(in: &cancellables)
     */
    
    // Download with Async/Await
    // function needs to be written with async to support concurrency
    let image = try? await loader.downloadImageWithAsync()
    await MainActor.run {
      self.image = image
    }
  }
  
}

struct DownloadImageWithAsync: View {
  @StateObject private var viewModel = DownloadImageWithAsyncViewModel()
  
  var body: some View {
    ZStack {
      if let image = viewModel.image {
        Image(uiImage: image)
          .resizable()
          .scaledToFill()
          .frame(maxWidth: .infinity, maxHeight: .infinity)
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
    .ignoresSafeArea()
    .onAppear {
      // viewModel.fetchImage()
      
      Task {
        await viewModel.fetchImage()
      }
    }
  }
}

struct DownloadImageWithAsync_Previews: PreviewProvider {
  static var previews: some View {
    DownloadImageWithAsync()
  }
}
