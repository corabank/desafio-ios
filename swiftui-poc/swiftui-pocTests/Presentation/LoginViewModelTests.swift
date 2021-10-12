import XCTest
@testable import swiftui_poc

class LoginViewModelTests: XCTestCase {
    
    private let sut = LoginViewModel()
    
    func testDefaultInit() {
        XCTAssertEqual(sut.state, .initial)
        
        XCTAssert(sut.attributes.email.isEmpty)
        XCTAssert(sut.attributes.password.isEmpty)
        
        XCTAssertFalse(sut.canSubmit)
    }
}
