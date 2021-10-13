import XCTest
@testable import swiftui_poc

class CouldNotParseLocalFileExceptionTests: XCTestCase {
    
    private let sut = CouldNotParseLocalFileException(object: TransactionResponse.self, file: "localFile", ext: "ext")
    
    func testExceptionSpecs() {
        XCTAssertEqual(sut.domain, "data layer")
        XCTAssertEqual(sut.code, 1)
        XCTAssertEqual(sut.localizedDescription, "could parse TransactionResponse.Type from local file localFile.ext")
    }
}
