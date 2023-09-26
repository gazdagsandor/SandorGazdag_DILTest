//
//  DrawingPointTests.swift
//  DILTestTests
//
//  Created by Gazdag Sandor on 2023. 09. 25..
//

import XCTest

import XCTest
@testable import DILTest

final class DrawingPointTests: XCTestCase {
    
    func test_init() {
        let point1 = DrawingPoint(point: .zero, time: 1)
        let point2 = DrawingPoint(point: CGPoint(x: 1, y: 2), time: 3)

        XCTAssertEqual(point1.x, .zero)
        XCTAssertEqual(point1.y, .zero)
        XCTAssertEqual(point1.time, 1)

        XCTAssertEqual(point2.x, 1)
        XCTAssertEqual(point2.y, 2)
        XCTAssertEqual(point2.time, 3)
    }
}
