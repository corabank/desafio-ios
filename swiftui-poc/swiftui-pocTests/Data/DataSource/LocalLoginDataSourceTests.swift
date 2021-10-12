import XCTest
import RxBlocking
@testable import swiftui_poc

class LocalLoginDataSourceTests: XCTestCase {
    
    private var generator = MockDataGenerator()
    private lazy var sut = LocalLoginDataSource(generator: self.generator)
    
    func testSuccessfulPerformLogin() {
        // given
        self.generator.getBoolValue = true
        
        // when
        let request = LoginRequest(email: "", password: "")
        let response = sut.performLogin(request: request)
        
        // then
        let expected = LoginResponse(token: "local token")
        XCTAssertEqual(try response.toBlocking().first(), expected)
    }
    
    func testUnsuccessfulPerformLogin() {
        // given
        self.generator.getBoolValue = false
        
        // when
        let request = LoginRequest(email: "", password: "")
        let response = sut.performLogin(request: request)
        
        // then
        XCTAssertThrowsError(try response.toBlocking().first())
    }
}
