  //
  //  DoTryCatchThrow.swift
  //  SwiftUIAccessory
  //
  //  Created by MANAS VIJAYWARGIYA on 17/09/22.
  //

import SwiftUI

// do-catch
// try
// throws

class DoTryCatchThrowDatamanager {
  let isActive: Bool = false
  
  func getTitle() -> (title: String?, error: Error?) {
    if isActive {
      return ("New Text!", nil)
    } else {
      return (nil, URLError(.badURL))
    }
  }
  
    // Or,
  func getTitle2() -> Result<String, Error> {
    if isActive {
      return .success("New Text!")
    } else {
      return .failure(URLError(.appTransportSecurityRequiresSecureConnection))
    }
  }
  
    // Or, using throws
  func getTitle3() throws -> String {
    if isActive {
      return "New Text!"
    } else {
      throw URLError(.badServerResponse)
    }
  }
  
  func getTitle4() throws -> String {
    if isActive {
      return "Final Text!"
    } else {
      throw URLError(.badServerResponse)
    }
  }
}

class DoTryCatchThrowViewModel: ObservableObject {
  let manager = DoTryCatchThrowDatamanager()
  
  @Published var text: String = "Starting text."
  
  func fetchTitle() {
    /*
     let newTitle = manager.getTitle()
     //    if let newTitle = newTitle {
     //      self.text = newTitle
     //    }
     // Or,
     //    if let newTitle {
     //      self.text = newTitle
     //    }
     
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
    
    /*
     // If we put try?, we don;t care about if it throws error. if it gives value then self.text will get new title, otherwie nothing will happen.
     // This way(try?) we can use outside of dotrycatch block or even inside dotrycatch block. becoz we dont care about error when it throws.
     let title = try? manager.getTitle3()
     if let title {
     self.text = title
     }
     */
    
    /*
      // Very dangerous code (try!) - Not Recommended
      //    let title = try! manager.getTitle3()
      //    self.text = title
    */
    
    
    // if any of the functions throws error (fails) then whole do block fails & it will go to catch block.
    do {
      let title = try manager.getTitle3()
      self.text = title
      
      let finaltitle = try manager.getTitle4()
      self.text = finaltitle
    } catch let error {
      print(error.localizedDescription)
      self.text = error.localizedDescription
    }
  }
}

struct DoTryCatchThrow: View {
  @StateObject private var viewModel = DoTryCatchThrowViewModel()
  
  var body: some View {
    Text(viewModel.text)
      .frame(width: 300, height: 300)
      .background(Color.blue)
      .foregroundColor(.white)
      .onTapGesture {
        viewModel.fetchTitle()
      }
  }
}

struct DoTryCatchThrow_Previews: PreviewProvider {
  static var previews: some View {
    DoTryCatchThrow()
  }
}
