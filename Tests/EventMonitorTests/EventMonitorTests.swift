import XCTest
@testable import EventMonitor

final class EventMonitorTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(EventMonitor().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
