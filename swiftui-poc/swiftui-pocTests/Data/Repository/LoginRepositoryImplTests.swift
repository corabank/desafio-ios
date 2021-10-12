import XCTest
@testable import swiftui_poc

class LoginRepositoryImplTests: XCTestCase {
    
    private var dataSource = MockLoginDataSource()
    private lazy var sut = LoginRepositoryImpl(dataSource: self.dataSource)
    
    func testSuccessfulLogin() {
        // given
        let expected = LoginResponse(token: "local token")
        self.dataSource.loginResponseValue = .just(expected)
        
        // when
        let request = LoginRequest(email: "", password: "")
        let response = sut.login(request: request)
        
        // then
        XCTAssertEqual(try response.toBlocking().first(), expected)
    }
    
    func testUnsuccessfulLogin() {
        // given
        let expected = NSError(domain: "", code: 0, userInfo: nil)
        self.dataSource.loginResponseValue = .error(expected)
        
        // when
        let request = LoginRequest(email: "", password: "")
        let response = sut.login(request: request)
        
        // then
        XCTAssertThrowsError(try response.toBlocking().first())
    }
}
