//
//  DrawingManagerTests.swift
//  DILTestTests
//
//  Created by Gazdag Sandor on 2023. 09. 26..
//

import XCTest
@testable import DILTest

final class DrawingManagerTests: XCTestCase {
    
    
    func test_beginDrawing() {
        let sut = makeSUT()
        let testTool = DrawingTool(color: .red, delay: .zero)
        sut.selectedTool = testTool
        
        sut.beginDrawing()
        
        XCTAssertEqual(sut.drawingLines.count, 1)
        XCTAssertNotNil(sut.timer)
        XCTAssertEqual(sut.timer?.isValid, true)
    }
    
    func test_addNewDrawingPoint_pointsScheduled() {
        let sut = makeSUT()
        let testTool = DrawingTool(color: .red, delay: 0.2)
        sut.selectedTool = testTool
        sut.beginDrawing()

        sut.addNewDrawingPoint(CGPoint(x: 1, y: 2))
        
        XCTAssertEqual(sut.drawingLines.count, 1)
        XCTAssertEqual(sut.drawingLines[0].scheduledPoints[0].x, 1)
        XCTAssertEqual(sut.drawingLines[0].scheduledPoints[0].y, 2)
    }

    func test_addNewDrawingPoint_pointsDrawn() {
        let delegate = MockDrawingManagerDelegate()
        let expectation = XCTestExpectation(description: "com.diltest.delegatecall")
        let sut = makeSUT()
        let testTool = DrawingTool(color: .red, delay: .zero)
        sut.selectedTool = testTool
        delegate.expectation = expectation
        sut.delegate = delegate
        sut.beginDrawing()
        
        sut.addNewDrawingPoint(CGPoint(x: 1, y: 2))
        
        XCTAssertEqual(sut.drawingLines.count, 1)
        XCTAssertEqual(sut.drawingLines[0].scheduledPoints[0].x, 1)
        XCTAssertEqual(sut.drawingLines[0].scheduledPoints[0].y, 2)
        
        wait(for: [expectation], timeout: 0.5)
        
        XCTAssertEqual(sut.drawingLines[0].drawablePoints.count, 1)
        XCTAssertEqual(sut.drawingLines[0].drawablePoints[0].x, 1)
        XCTAssertEqual(sut.drawingLines[0].drawablePoints[0].y, 2)
        XCTAssertEqual(delegate.pathsDidChangeCalled, 1)
    }
    
    func test_activate() {
        var checkFlag: Int = .zero
        let sut = makeSUT()
        let testTool = DrawingTool(color: .red, delay: .zero) {
            checkFlag = 1
        }
        sut.selectedTool = testTool

        sut.activate(tool: testTool)
        XCTAssertEqual(checkFlag, 1)
    }
    
    func test_eraseAll() {
        let sut = makeSUT()
        let testTool = DrawingTool(color: .red, delay: .zero)
        sut.selectedTool = testTool
        sut.beginDrawing()
        sut.addNewDrawingPoint(CGPoint(x: 1, y: 2))
        
        XCTAssertFalse(sut.drawingLines.isEmpty)
        
        sut.eraseAll()
        
        XCTAssertTrue(sut.drawingLines.isEmpty)
    }
    
    func makeSUT() -> DrawingManager {
        let sut = DrawingManager()
        return sut
    }
}
