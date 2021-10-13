import XCTest
@testable import swiftui_poc

class CouldNotLoginExceptionTests: XCTestCase {

    private let sut = CouldNotLoginException()
    
    func testExceptionSpecs() {
        XCTAssertEqual(sut.domain, "data layer")
        XCTAssertEqual(sut.code, 0)
        XCTAssertEqual(sut.localizedDescription, "unexpected error")
    }
}
