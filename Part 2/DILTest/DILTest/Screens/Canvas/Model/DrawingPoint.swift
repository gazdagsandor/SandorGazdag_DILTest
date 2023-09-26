//
//  DrawingPoint.swift
//  DILTest
//
//  Created by Gazdag Sandor on 2023. 09. 26..
//

import Foundation

struct DrawingPoint {
    let point: CGPoint
    let time: TimeInterval
    
    var x: CGFloat {
        point.x
    }
    var y: CGFloat {
        point.y
    }
}

