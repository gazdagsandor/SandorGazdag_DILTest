//
//  DrawingPath.swift
//  DILTest
//
//  Created by Gazdag Sandor on 2023. 09. 26..
//

import Foundation

class DrawingPath {
    let id: UUID = UUID()
    let tool: DrawingTool
    
    var drawablePoints: [DrawingPoint]
    var scheduledPoints: [DrawingPoint]
    var isDrawingFinished: Bool
    var isFinished: Bool {
        isDrawingFinished && scheduledPoints.isEmpty
    }
    
    init(tool: DrawingTool, drawablePoints: [DrawingPoint] = [], scheduledPoints: [DrawingPoint] = [], isFinished: Bool = false) {
        self.tool = tool
        self.drawablePoints = drawablePoints
        self.scheduledPoints = scheduledPoints
        self.isDrawingFinished = isFinished
    }
}

extension DrawingPath: Equatable {
    static func == (lhs: DrawingPath, rhs: DrawingPath) -> Bool {
        lhs.id == rhs.id
    }
}
