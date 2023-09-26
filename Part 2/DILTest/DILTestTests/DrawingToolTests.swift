//
//  DrawingToolTests.swift
//  DILTestTests
//
//  Created by Gazdag Sandor on 2023. 09. 25..
//

import XCTest
@testable import DILTest

final class DrawingToolTests: XCTestCase {

    func test_init() {
        let red = DrawingTool.red
        let blue = DrawingTool.blue
        let green = DrawingTool.green
        
        XCTAssertEqual(red.color, .red)
        XCTAssertEqual(red.delay, 1)
        
        XCTAssertEqual(blue.color, .blue)
        XCTAssertEqual(blue.delay, 3)
        
        XCTAssertEqual(green.color, .green)
        XCTAssertEqual(green.delay, 5)
    }
}
