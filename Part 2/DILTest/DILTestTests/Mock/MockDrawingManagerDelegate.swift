//
//  MockDrawingManagerDelegate.swift
//  DILTestTests
//
//  Created by Gazdag Sandor on 2023. 09. 26..
//

import XCTest
@testable import DILTest

class MockDrawingManagerDelegate: DrawingManagerDelegate {

    var pathsDidChangeCalled: Int = .zero
    var expectation: XCTestExpectation?
    
    func pathsDidChange() {
        pathsDidChangeCalled += 1
        expectation?.fulfill()
    }
}
