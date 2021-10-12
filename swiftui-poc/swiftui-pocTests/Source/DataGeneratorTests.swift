import XCTest
@testable import swiftui_poc

class DataGeneratorTests: XCTestCase {
    
    private let sut = DataGenerator.shared
    
    func testGetBool() {
        let result = sut.getBool()
        XCTAssertNotNil(result)
    }
}
