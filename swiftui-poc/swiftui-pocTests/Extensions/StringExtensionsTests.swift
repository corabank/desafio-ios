import XCTest
@testable import swiftui_poc

class StringExtensionsTests: XCTestCase {
    
    func testIsNotEmpty() {
        var string = ""
        XCTAssertFalse(string.isNotEmpty)
        
        string = "Test Case"
        XCTAssertTrue(string.isNotEmpty)
    }
}
