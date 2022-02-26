//
//  DownloadWithEscaping.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 26/02/22.
//

import SwiftUI

//struct DownloadWithEscapingModel: Identifiable, Codable {
//    let userId: Int
//    let id: Int
//    let title: String
//    let body: String
//}
// https://app.quicktype.io
struct DownloadWithEscapingModel: Identifiable, Codable {
    let userID, id: Int
    let title, body: String
    
    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}


class DownloadWithEscapingViewModel : ObservableObject {
    @Published var newPersons: [DownloadWithEscapingModel] = []
    
    init(){
        getPosts()
    }
    
    func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        downloadData(fromUrl: url) { returnedData in
            if let data = returnedData {
                guard let newPersons = try? JSONDecoder().decode([DownloadWithEscapingModel].self, from: data) else { return }
                // This will run in main thread
                DispatchQueue.main.async {[weak self] in
                    // self?.newPersons.append(newPersons)
                    self?.newPersons = newPersons
                }
            } else {
                print("No Data returned")
            }
        }
    }
    
    // Generic Method
    func downloadData(fromUrl url: URL, completionHandler: @escaping (_ data: Data?) -> ()) {
        // This will run in background Thread automatically
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let data = data,
                error == nil ,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300
            else {
                print("Error downloading data")
                completionHandler(nil)
                return
            }
            
            // guard error == nil else {
               // print("Error: \(String(describing: error))")
               // return
            // }
            
            // guard let response = response as? HTTPURLResponse else {
               // print("Invalid Response!")
               // return
            // }
            
            // guard response.statusCode >= 200 && response.statusCode < 300 else {
               // print("Response Status code should be 2xx, but is \(response.statusCode)")
               // return
            // }
            
            completionHandler(data)
            
        }.resume()
    }
}
struct DownloadWithEscaping: View {
    @StateObject var vm = DownloadWithEscapingViewModel()
    
    var body: some View {
        List {
            ForEach(vm.newPersons) {person in
                VStack(alignment: .leading) {
                    Text(person.title)
                        .font(.headline)
                    Text(person.body)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

struct DownloadWithEscaping_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithEscaping()
    }
}
