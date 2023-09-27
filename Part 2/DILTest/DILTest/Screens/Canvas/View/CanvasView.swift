//
//  CanvasView.swift
//  DILTest
//
//  Created by Gazdag Sandor on 2023. 09. 25..
//

import UIKit

class CanvasView: UIView {
    
    private struct Constants {
        static let defaultWidth: CGFloat = 2.0
    }
    
    var selectedTool: DrawingTool? {
        didSet {
            drawingManager?.selectedTool = selectedTool
        }
    }
    var lineWidth: CGFloat = Constants.defaultWidth
    
    let drawQueue: DispatchQueue = DispatchQueue(label: "com.drawing.queue")
    var workItems: [DispatchWorkItem] = []
    
    var drawingManager: DrawingManager?
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        drawingManager?.drawingLines.forEach { (line) in
            for (index, point) in line.drawablePoints.enumerated() {
                let destinationPoint = CGPoint(x: point.x, y: point.y)
                if index == .zero {
                    context.move(to: destinationPoint)
                } else {
                    context.addLine(to: destinationPoint)
                }
                context.setStrokeColor(line.tool.color.cgColor)
                context.setLineWidth(lineWidth)
            }
            context.setLineCap(.round)
            context.strokePath()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        drawingManager?.beginDrawing()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchPoint = touches.first?.location(in: self) else {
            return
        }
        drawingManager?.addNewDrawingPoint(touchPoint)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        drawingManager?.finishDrawing()
    }
    
    func activate(tool: DrawingTool) {
        drawingManager?.activate(tool: tool)
    }
    
    func eraseAll() {
        drawingManager?.eraseAll()
    }
}

extension CanvasView: DrawingManagerDelegate {

    func pathsDidChange() {
        setNeedsDisplay()
    }
}
