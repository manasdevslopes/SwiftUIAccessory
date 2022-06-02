//
//  Profile.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 02/06/22.
//

import SwiftUI

struct Profile: Identifiable {
  var id = UUID().uuidString
  var userName: String
  var profilePicture: String
  var lastMsg: String
  var lastActive: String
}

var profiles = [
  Profile(userName: "Manas", profilePicture: "_iosmanas", lastMsg: "Hi! I'm an iOS Developer w/ SwiftUI", lastActive: "04:26 PM"),
  Profile(userName: "Ashi", profilePicture: "i_ashisinghh", lastMsg: "Hi Manas, kese ho ?", lastActive: "04:26 PM"),
  Profile(userName: "Krishna", profilePicture: "Manas3", lastMsg: "Need to create an iOS App in SwiftUI", lastActive: "06:25 PM"),
  Profile(userName: "Shikha", profilePicture: "shikha", lastMsg: "Hi! kab pahonch rhe?", lastActive: "11:25 AM"),
  Profile(userName: "Maa", profilePicture: "maa", lastMsg: "Hi! packng start krte hai", lastActive: "08:25 PM"),
  Profile(userName: "Papa", profilePicture: "papa", lastMsg: "Hi! packng start krte hai", lastActive: "08:25 PM"),
  Profile(userName: "Kalyani Di", profilePicture: "kalyanidi", lastMsg: "Hi bhai! kese ho?", lastActive: "04:25 PM"),
]
