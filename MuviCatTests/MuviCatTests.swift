//
//  MuviCatTests.swift
//  MuviCatTests
//
//  Created by Abdhi on 18/07/21.
//

import XCTest

@testable import Pods_MuviCat
class MuviCatTests: XCTestCase {

    func sampleTest() {
        let output = 1
        let input = 1
        XCTAssertEqual(output, input, "Failed to produce \(output) from \(input)")
    }
}
