//
//  DoTryCatchThrows.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 11/05/22.
//

import SwiftUI

class DoTryCatchThrowsDataManager {
  let isActive: Bool = true
  
  func getTitle() -> (title: String?, error: Error?) {
    if isActive {
      return ("NEW TEXT!", nil)
    } else {
      return (nil, URLError(.badURL))
    }
  }
  
  func getTitle2() -> Result<String, Error> {
    if isActive {
      return .success("NEW TEXT!")
    } else {
      return .failure(URLError(.appTransportSecurityRequiresSecureConnection))
    }
  }
  
  func getTitle3() throws -> String {
//    if isActive {
//      return "NEW TEXT!"
//    } else {
      throw URLError(.badServerResponse)
//    }
  }
  
  func getTitle4() throws -> String {
    if isActive {
      return "FINAL TEXT!"
    } else {
      throw URLError(.badServerResponse)
    }
  }
}

class DoTryCatchThrowsViewModel: ObservableObject {
  @Published var text: String = "Starting Text..."
  let manager = DoTryCatchThrowsDataManager()
  
  func fetchTitle() {
    /*
    let returnedValue = manager.getTitle()
    if let newTitle = returnedValue.title {
      self.text = newTitle
    } else if let error = returnedValue.error {
      self.text = error.localizedDescription
    }
     */
    
    /*
    let result = manager.getTitle2()
    switch result {
      case .success(let newTitle):
        self.text = newTitle
      case .failure(let error):
        self.text = error.localizedDescription
    }
     */
    
    do {
      let newTitle = try? manager.getTitle3()
      if let newTitle = newTitle {
        self.text = newTitle
      }
      
      let finalTitle = try manager.getTitle4()
      self.text = finalTitle
    } catch let error {
      self.text = error.localizedDescription
    }
  }
}

struct DoTryCatchThrows: View {
  @StateObject private var vm = DoTryCatchThrowsViewModel()
  
  var body: some View {
    Text(vm.text)
      .frame(width: 300, height: 300)
      .background(Color.blue)
      .onTapGesture {
        vm.fetchTitle()
      }
  }
}

struct DoTryCatchThrows_Previews: PreviewProvider {
    static var previews: some View {
        DoTryCatchThrows()
    }
}
