import XCTest
@testable import UI

final class UITests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(UI().text, "Hello, World!")
    }
}
