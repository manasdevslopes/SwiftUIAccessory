//
//  CodableBootcamp1.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 26/02/22.
//

import SwiftUI

struct CustomersModel1: Identifiable, Decodable, Encodable {
    var id: String
    let name: String
    let points: Int
    let isPremium: Bool
    
    enum CodingKeys: String, CodingKey {
        case id, name, points, isPremium
    }
    
    init(id: String, name: String, points: Int, isPremium: Bool) {
        self.id = id
        self.name = name
        self.points = points
        self.isPremium = isPremium
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.points = try container.decode(Int.self, forKey: .points)
        self.isPremium = try container.decode(Bool.self, forKey: .isPremium)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(points, forKey: .points)
        try container.encode(isPremium, forKey: .isPremium)
        
    }
}
class CodableViewModel1: ObservableObject {
    @Published var customer: CustomersModel1? = nil
    
    init() {
        getData()
    }
    
    func getData() {
        guard let data = getJSONData() else { return }
        do {
            self.customer = try JSONDecoder().decode(CustomersModel1.self, from: data)
        } catch let error {
            print("Error Decoding : \(error.localizedDescription)")
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
    
    func encodeData() ->  Data? {
        let customer = CustomersModel1(id: "1111", name: "Ashi", points: 5, isPremium: true)
        let jsonData = try? JSONEncoder().encode(customer)
        
        return jsonData
    }
}

struct CodableBootcamp1: View {
    @StateObject var vm = CodableViewModel1()
    
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

struct CodableBootcamp1_Previews: PreviewProvider {
    static var previews: some View {
        CodableBootcamp1()
    }
}
