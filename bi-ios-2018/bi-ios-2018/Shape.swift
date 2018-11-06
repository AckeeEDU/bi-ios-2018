//
//  Shape.swift
//  bi-ios-2018
//
//  Created by Dominik Vesely on 06/11/2018.
//  Copyright © 2018 ČVUT. All rights reserved.
//

import Foundation
import UIKit

struct Shape : Equatable {
    enum ShapeType {
        case rectangle
        case circle
    }
    
    var tag : Int
    var color : UIColor
    var size : Float
    var origin : CGPoint
}
