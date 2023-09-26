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
    
    var referenceLines: [DrawingPath] = []
    var drawingLines: [DrawingPath] = []
    var selectedTool: DrawingTool?
    var lineWidth: CGFloat = Constants.defaultWidth
    
    let drawQueue: DispatchQueue = DispatchQueue(label: "com.drawing.queue")
    var workItems: [DispatchWorkItem] = []
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        drawingLines.forEach { (line) in
            for (index, point) in (line.points?.enumerated())! {
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
        guard let selectedTool = selectedTool else {
            return
        }
        let path = DrawingPath(tool: selectedTool, points: [])
        drawingLines.append(path)
        referenceLines.append(path)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let selectedTool = selectedTool, let touchPoint = touches.first?.location(in: self) else {
            return
        }
        guard var lastLine = referenceLines.popLast() else {
            return
        }
        lastLine.points?.append(DrawingPoint(point: touchPoint, time: CACurrentMediaTime()))
        lastLine.tool = selectedTool
        referenceLines.append(lastLine)
        
        let workItem = DispatchWorkItem { [weak self] in
            self?.drawingLines.append(lastLine)
            DispatchQueue.main.async {
                self?.setNeedsDisplay()
            }
        }
        workItems.append(workItem)
        drawQueue.asyncAfter(deadline: .now() + .seconds(Int(selectedTool.delay)), execute: workItem)
    }
    
    func activate(tool: DrawingTool) {
        guard tool.delay > .zero else {
            tool.action?()
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(Int(tool.delay))) {
            tool.action?()
        }
    }
    
    func eraseAll() {
        workItems.forEach { $0.cancel() }
        drawingLines = []
        referenceLines = []
        setNeedsDisplay()
    }
}



