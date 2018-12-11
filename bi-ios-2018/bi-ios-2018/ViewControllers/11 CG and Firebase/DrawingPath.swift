//
//  DrawingPath.swift
//  bi-ios-2018
//
//  Created by Jan Misar on 11/12/2018.
//  Copyright © 2018 ČVUT. All rights reserved.
//

import UIKit

class DrawingPath: Codable {
    
    var key: String?
    var points: [CGPoint] = []
    var lineWidth: CGFloat = 2
    
}
