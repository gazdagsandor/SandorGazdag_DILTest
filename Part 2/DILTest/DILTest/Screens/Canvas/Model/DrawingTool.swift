//
//  DrawingTool.swift
//  DILTest
//
//  Created by Gazdag Sandor on 2023. 09. 26..
//

import UIKit

typealias DrawingToolAction = () -> Void

struct DrawingTool {
    
    static let red = DrawingTool(color: .red, delay: 1.0)
    static let blue = DrawingTool(color: .blue, delay: 3.0)
    static let green = DrawingTool(color: .green, delay: 5.0)
    
    let color: UIColor
    let delay: TimeInterval
    let action: DrawingToolAction?
    
    init(color: UIColor, delay: TimeInterval = .zero, action: DrawingToolAction? = nil) {
        self.color = color
        self.delay = delay
        self.action = action
    }
}
