import XCTest
@testable import swiftui_poc

class BoolExtensionsTests: XCTestCase {
    
    func testNegated() {
        var bool = true
        XCTAssertFalse(bool.negated)
        
        bool = false
        XCTAssertTrue(bool.negated)
    }
}
