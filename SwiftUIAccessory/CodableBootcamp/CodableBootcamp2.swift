//
//  CodableBootcamp2.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 26/02/22.
//

import SwiftUI

struct CustomersModel2: Identifiable, Codable {
    var id: String
    let name: String
    let points: Int
    let isPremium: Bool
}

class CodableViewModel2: ObservableObject {
    @Published var customer: CustomersModel2? = nil
    
    init() {
        getData()
    }
    
    func getData() {
        guard let data = getJSONData() else { return }
        self.customer = try? JSONDecoder().decode(CustomersModel2.self, from: data)
    }
    
    func getJSONData() -> Data? {
        let customer = CustomersModel1(id: "1111", name: "Ashi", points: 5, isPremium: true)
        let jsonData = try? JSONEncoder().encode(customer)

        return jsonData
    }
}

struct CodableBootcamp2: View {
    @StateObject var vm = CodableViewModel2()
    
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

struct CodableBootcamp2_Previews: PreviewProvider {
    static var previews: some View {
        CodableBootcamp2()
    }
}
