//
//  ImageSaveResult.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 10/05/22.
//

import Foundation
import SwiftUI

enum ImageSaveStatus {
  case success
  case error
  case libraryPermissionDenied
}

struct ImageSaveResult: Identifiable {
  let id = UUID()
  let saveStatus: ImageSaveStatus
}
