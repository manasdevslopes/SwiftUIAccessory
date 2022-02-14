//
//  ArraysBootcamp.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 14/02/22.
//

import SwiftUI

struct UserModel: Identifiable {
    let id = UUID().uuidString
    let name : String?
    let points: Int
    let isVerified: Bool
}

class ArrayModificationViewModel: ObservableObject {
    @Published var dataArray: [UserModel] = []
    @Published var filteredArray: [UserModel] = []
    @Published var mapArray: [String] = []
    
    init() {
        getUsers()
        // sortArray()
        // updateFilteredArray()
//        mappedArray()
        combineAllThree()
    }
    
    func combineAllThree() {
        mapArray = dataArray
                    .sorted(by: { $0.points > $1.points })
                    .filter({ $0.isVerified })
                    .compactMap({ $0.name })
    }
    
    func mappedArray() {
        //        mapArray = dataArray.map({ (user) -> String in
        //            return user.name ?? "Error"
        //        })
        
        // Short
        // mapArray = dataArray.map({ $0.name ?? "Error"})
        
        /*compactMap
         If name property is optional and from data it is coming as nil, then we can use compactMap -> eg as below
         User with no name is not included in the array with compactMap
         */
        //        mapArray = dataArray.compactMap({ (user) -> String? in
        //            return user.name
        //        })
        
        // Short
        mapArray = dataArray.compactMap({ $0.name })
    }
    
    func updateFilteredArray() {
        //        filteredArray = dataArray.filter({ (user) -> Bool in
        //            return user.points >= 4
        //        })
        //        filteredArray = dataArray.filter({ (user) -> Bool in
        //            return user.isVerified
        //        })
        
        //        filteredArray = dataArray.filter({$0.name.contains("s")})
        
        // Short
        filteredArray = dataArray.filter({$0.isVerified})
    }
    
    func sortArray() {
        // sort
        //        filteredArray = dataArray.sorted { (user1, user2) -> Bool in
        //            return user1.points > user2.points
        //        }
        // Short
        filteredArray = dataArray.sorted(by: { $0.points > $1.points })
    }
    
    func getUsers() {
        let user1 = UserModel(name: "Manas", points: 5, isVerified: true)
        let user2 = UserModel(name: "Ashi", points: 5, isVerified: true)
        let user3 = UserModel(name: "Randeep", points: 4, isVerified: true)
        let user4 = UserModel(name: "Krishna", points: 7, isVerified: true)
        let user5 = UserModel(name: "Siddharth", points: 4, isVerified: true)
        let user6 = UserModel(name: "Kalyani Di", points: 8, isVerified: true)
        let user7 = UserModel(name: "Shikha", points: 4, isVerified: false)
        let user8 = UserModel(name: nil, points: 3, isVerified: false)
        let user9 = UserModel(name: nil, points: 2, isVerified: false)
        let user10 = UserModel(name: "Steve", points: 10, isVerified: true)
        dataArray.append(contentsOf: [
            user1,
            user2,
            user3,
            user4,
            user5,
            user6,
            user7,
            user8,
            user9,
            user10,
        ])
    }
}

struct ArraysBootcamp: View {
    @StateObject var vm = ArrayModificationViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(vm.mapArray, id: \.self) {name in
                    Text(name)
                        .font(.title)
                }
                //                ForEach(vm.filteredArray) {user in
                //                    VStack(alignment: .leading) {
                //                        Text(user.name)
                //                            .font(.headline)
                //                        HStack {
                //                            Text("Points: \(user.points)")
                //                            Spacer()
                //                            if user.isVerified {
                //                                Image(systemName: "checkmark.seal.fill")
                //                                    .symbolRenderingMode(.palette)
                //                                    .foregroundStyle(
                //                                        Color.white, Color.blue
                //                                    )
                //                            }
                //                        }
                //                    }
                //                    .foregroundColor(.white)
                //                    .padding()
                //                    .background(Color.black.opacity(0.9).cornerRadius(10))
                //                    .padding(.horizontal)
                //                }
            }
        }
    }
}

struct ArraysBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ArraysBootcamp()
    }
}
