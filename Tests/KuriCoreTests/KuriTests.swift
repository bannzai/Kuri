import XCTest
@testable import Kuri

class KuriTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Kuri().text, "Hello, World!")
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
