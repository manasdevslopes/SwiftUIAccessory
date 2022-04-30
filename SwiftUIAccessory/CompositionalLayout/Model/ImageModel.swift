//
//  ImageModel.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 30/04/22.
//

import Foundation

struct ImageModel: Identifiable, Codable, Hashable {
    var id: String
    var download_url: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case download_url
    }
}
