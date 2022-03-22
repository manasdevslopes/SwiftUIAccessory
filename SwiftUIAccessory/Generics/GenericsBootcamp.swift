//
//  GenericsBootcamp.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 22/03/22.
//

import SwiftUI

struct StringModel {
    let info: String?
    func removeInfo() -> StringModel {
        // we can remove return keyword as it only contains single line after return
        StringModel(info: nil)
    }
}

struct BoolModel {
    let info: Bool?
    func removeInfo() -> BoolModel {
        // we can remove return keyword as it only contains single line after return
        BoolModel(info: nil)
    }
}

struct GenericModel<CustomType> {
    let info: CustomType?
    func removeInfo() -> GenericModel {
        // we can remove return keyword as it only contains single line after return
        GenericModel(info: nil)
    }
    
}

class GenericsViewModel: ObservableObject {
    @Published var stringModel = StringModel(info: "Hello World!")
    @Published var boolModel = BoolModel(info: true)
    
    @Published var genericStringModel = GenericModel(info: "Hello World!")
    @Published var genericBoolModel = GenericModel(info: true)
    
    func removeData() {
        stringModel = stringModel.removeInfo()
        boolModel = boolModel.removeInfo()
        genericStringModel = genericStringModel.removeInfo()
        genericBoolModel = genericBoolModel.removeInfo()
    }
}


// Generics used in View example
struct GenericView<CustomType: View> : View {
    let title: String
    let content: CustomType
    // this content could be anything not just Text with string , anything that conforms to View like button or any component or new screen
    // in short we can write "T" instead of CustomType
    var body: some View {
        HStack {
            Text(title)
            content
        }
    }
}

struct GenericsBootcamp: View {
    @StateObject private var vm = GenericsViewModel()
    
    var body: some View {
        VStack {
            GenericView(title: "New View.....", content: Text("HelloWorld!"))
            Text(vm.stringModel.info ?? "no data")
            Text(vm.boolModel.info?.description ?? "no data")
            Text(vm.genericStringModel.info ?? "no data")
            Text(vm.genericBoolModel.info?.description ?? "no data")
        }
        .onTapGesture {
            vm.removeData()
        }
    }
}

struct GenericsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        GenericsBootcamp()
    }
}
