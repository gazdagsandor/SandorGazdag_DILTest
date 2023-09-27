//
//  DrawingManager.swift
//  DILTest
//
//  Created by Gazdag Sandor on 2023. 09. 26..
//

import UIKit

protocol DrawingManagerDelegate: AnyObject {
    func pathsDidChange()
}

class DrawingManager {
    weak var delegate: DrawingManagerDelegate?
    
    var drawingLines: [DrawingPath] = []

    var selectedTool: DrawingTool?
    var scheduledTool: DrawingTool?

    var timer: Timer?

    // MARK: - Timer
    
    private func setupTimer() {
        guard timer == nil else { return }
        timer = Timer.scheduledTimer(withTimeInterval: 0.04, repeats: true, block: { [weak self] _ in
            self?.setDrawables()
            self?.executeScheduledTools()
            self?.delegate?.pathsDidChange()
        })
    }
    
    private func removeTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func executeScheduledTools() {
        let filterTime = CFAbsoluteTimeGetCurrent()
        guard let tool = scheduledTool, let baseTime = tool.baseTime, filterTime > baseTime + tool.delay else { return }
        tool.action?()
        scheduledTool = nil
    }
    
    private func setDrawables() {
        let filterTime = CFAbsoluteTimeGetCurrent()
        for path in drawingLines where !path.isFinished {
            let points = path.scheduledPoints.filter { $0.time < filterTime }
            path.scheduledPoints.removeAll { $0.time < filterTime }
            path.drawablePoints.append(contentsOf: points)
        }
    }

    // MARK: - Drawing

    func beginDrawing() {
        setupTimer()
        guard let selectedTool = selectedTool else {
            return
        }
        let path = DrawingPath(tool: selectedTool)
        drawingLines.append(path)
    }
    
    func finishDrawing() {
        drawingLines.last?.isDrawingFinished = true
    }
    
    func addNewDrawingPoint(_ point: CGPoint) {
        guard let selectedTool = selectedTool else {
            return
        }
        guard let lastLine = drawingLines.last else {
            return
        }
        let futureTime = CFAbsoluteTimeGetCurrent() + selectedTool.delay
        let point = DrawingPoint(point: point, time: futureTime)
        lastLine.scheduledPoints.append(point)
    }
    
    // MARK: Tool handling
    
    func activate(tool: DrawingTool) {
        guard tool.delay > .zero else {
            tool.action?()
            return
        }
        scheduledTool = tool
    }
    
    func eraseAll() {
        removeTimer()
        drawingLines = []
    }
    
}

