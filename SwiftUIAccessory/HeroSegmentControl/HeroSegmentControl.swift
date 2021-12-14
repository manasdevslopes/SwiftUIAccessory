//
//  HeroSegmentControl.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 14/12/21.
//

import SwiftUI

struct HeroSegmentControl: View {
    @State private var selectedSide: SideOfTheForce = .light
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .yellow
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
    }
    var body: some View {
        NavigationView {
            VStack {
                Picker("Choose a side", selection: $selectedSide) {
                    // using case iterable in enum, we can use all cases so that we can use the enum values as an array
                    ForEach(SideOfTheForce.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
//                .pickerStyle(SegmentedPickerStyle())
                .pickerStyle(.segmented)
                .padding()
                
                Spacer()
                ChoosenHeroView(selectedSide: selectedSide)
                Spacer()
            }
            .navigationTitle("Choose a side")
        }
    }
}

enum SideOfTheForce: String, CaseIterable {
    case light = "Light"
    case grey = "Grey"
    case dark = "Dark"
}

struct ChoosenHeroView: View {
    var selectedSide: SideOfTheForce
    
    var body: some View {
        switch selectedSide {
        case .light:
            HeroImageView(heroName: "Anakin")
        case .grey:
            HeroImageView(heroName: "Ahsoka")
        case .dark:
            HeroImageView(heroName: "vader")
        }
    }
}


struct HeroImageView: View {
    var heroName: String
    
    var body: some View {
        Image(heroName)
            .resizable()
            .frame(width: 250, height: 400)
            .shadow(color: .white, radius: 100)
    }
}

struct HeroSegmentControl_Previews: PreviewProvider {
    static var previews: some View {
        HeroSegmentControl()
    }
}
