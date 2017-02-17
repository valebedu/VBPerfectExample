//
//  VabeExampleTests.swift
//  VabeExample
//
//  Created by Valentin Bercot on 17/02/2017.
//
//

import XCTest
@testable import VabeExample

class VabeExampleTests: XCTestCase
{
    func testExample()
    {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        let text = "Hello, World!"
        XCTAssertEqual(text, "Hello, World!")
    }


    static var allTests : [(String, (VabeExampleTests) -> () throws -> Void)]
    {
        return [
            ("testExample", testExample)
        ]
    }
}
