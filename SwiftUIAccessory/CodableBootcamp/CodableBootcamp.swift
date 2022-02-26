//
//  CodableBootcamp.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 26/02/22.
//

import SwiftUI

struct CustomersModel: Identifiable {
    var id: String
    let name: String
    let points: Int
    let isPremium: Bool
}
class CodableViewModel: ObservableObject {
    @Published var customer: CustomersModel? = nil
    
    init() {
        getData()
    }
    
    func getData() {
        guard let data = getJSONData() else { return }
        // print("JSON Data: \(data )")
        // let jsonString = String(data: data, encoding: .utf8)
        // print("JSONString: \(jsonString)")
        if let localData = try? JSONSerialization.jsonObject(with: data, options: []),
           let dictionary = localData as? [String: Any] ,
        
            let id = dictionary["id"] as? String,
            let name = dictionary["name"] as? String,
            let points = dictionary["points"] as? Int,
            let isPremium = dictionary["isPremium"] as? Bool
        {
            
//            let id = dictionary["id"] as? String ?? ""
//            let name = dictionary["name"] as? String ?? ""
//            let points = dictionary["points"] as? Int ?? 0
//            let isPremium = dictionary["isPremium"] as? Bool ?? false
            
            let newCustomer = CustomersModel(id: id, name: name, points: points, isPremium: isPremium)
            customer = newCustomer
        }
        
    }
    
    func getJSONData() -> Data? {
        let dictionary: [String: Any] = [
            "id": "12345",
            "name": "Manas",
            "points": 5,
            "isPremium": true,
        
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
        return jsonData
    }
}

struct CodableBootcamp: View {
    @StateObject var vm = CodableViewModel()
    
    var body: some View {
        VStack {
            if let customer = vm.customer {
                Text(customer.id)
                Text(customer.name)
                Text("\(customer.points)")
                Text(customer.isPremium.description)
            }
        }
    }
}

struct CodableBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CodableBootcamp()
    }
}
