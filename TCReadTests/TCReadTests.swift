//
//  TCReadTests.swift
//  TCReadTests
//
//  Created by Todd Cooke on 1/9/23.
//

import XCTest

@testable import TCRead

final class TCReadTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    // Carrol, Lewis -> Lewis Carrol
    // Van der Veldt, James Herman, 1893- -> James Herman Van der Veldt
    // Ollier, Edmund, 1827-1886; Wilson, Robert, 1846-1893 -> Edmund Ollier, Robert Wilson
    func testFormatAuthor() throws {
        var expected = "Lewis Carroll, Alice Gerstenberg"
        var output = "Carroll, Lewis, 1832-1898; Gerstenberg, Alice, 1885-1972".formatAuthorComplex()
        XCTAssertEqual(output, expected)

        expected = "James Herman Van der Veldt"
        output = "Van der Veldt, James Herman, 1893-".formatAuthorComplex()
        XCTAssertEqual(output, expected)

        expected = "Edmund Ollier, Robert Wilson"
        output = "Ollier, Edmund, 1827-1886; Wilson, Robert, 1846-1893".formatAuthorComplex()
        XCTAssertEqual(output, expected)

        expected = "Edmund Ollier, Robert Wilson"
        output = "Ollier, Edmund, 1827-1886; Wilson, Robert, 1846-1893".formatAuthorComplex()
        XCTAssertEqual(output, expected)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
