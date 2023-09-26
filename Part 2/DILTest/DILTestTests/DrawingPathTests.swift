//
//  DrawingPathTests.swift
//  DILTestTests
//
//  Created by Gazdag Sandor on 2023. 09. 25..
//

import XCTest
@testable import DILTest

final class DrawingPathTests: XCTestCase {
    
    func test_init() {
        let path1 = DrawingPath(tool: .blue, points: [])
        let path2 = DrawingPath(
            tool: .red,
            points: [
                DrawingPoint(point: .zero, time: 1),
                DrawingPoint(point: CGPoint(x: 1, y: 2), time: 2)
            ]
        )
        
        XCTAssertEqual(path1.tool.color, DrawingTool.blue.color)
        XCTAssertEqual(path1.points?.count, .zero)
        
        XCTAssertEqual(path2.tool.color, DrawingTool.red.color)
        XCTAssertEqual(path2.points?.count, 2)
        XCTAssertEqual(path2.points?[0].x, .zero)
        XCTAssertEqual(path2.points?[0].y, .zero)
        XCTAssertEqual(path2.points?[0].time, 1)
        XCTAssertEqual(path2.points?[1].x, 1)
        XCTAssertEqual(path2.points?[1].y, 2)
        XCTAssertEqual(path2.points?[1].time, 2)
    }
}

