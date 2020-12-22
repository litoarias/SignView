import XCTest
@testable import SignView

final class SignViewTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SignView().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
