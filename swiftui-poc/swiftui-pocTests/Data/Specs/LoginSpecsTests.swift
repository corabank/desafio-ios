import XCTest
@testable import swiftui_poc

class LoginSpecsTests: XCTestCase {
    
    private var requestSUT = LoginRequest(email: "email@email.com", password: "password")
    private var responseSUT = LoginResponse(token: "local token")
    
    func testDefaultRequestInit() {
        XCTAssertEqual(requestSUT.email, "email@email.com")
        XCTAssertEqual(requestSUT.password, "password")
    }
    
    func testDefaultResponseInit() {
        XCTAssertEqual(responseSUT.token, "local token")
    }
}
