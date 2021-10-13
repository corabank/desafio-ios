import XCTest
import RxSwift
@testable import swiftui_poc

class LocalFileReaderTests: XCTestCase {
    
    private let sut = LocalFileReader.shared
    
    func testNotNilData() {
        // given
        var response: Single<TransactionResponse>
        
        // when
        response = sut.read(file: "transactions", extension: "json")
        
        // then
        XCTAssertNotNil(try response.toBlocking().first())
    }

    func testNilData() {
        // given
        var response: Single<TransactionResponse>
        
        // when
        response = sut.read(file: "", extension: "")
        
        // then
        XCTAssertThrowsError(try response.toBlocking().first())
    }
}
