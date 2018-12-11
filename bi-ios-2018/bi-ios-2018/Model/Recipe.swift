//
//  Recipe.swift
//  bi-ios-2018
//
//  Created by Dominik Vesely on 04/12/2018.
//  Copyright © 2018 ČVUT. All rights reserved.
//

import Foundation

// {"name":"Ackee and Saltfish","duration":10,"id":"5a00be7f0898a11000146b64","score":0}
struct Recipe : Codable {
    var name : String
    var duration : Int
    var id : String
    var score : Int
    var rating: Int?
}
