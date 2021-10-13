import XCTest
@testable import swiftui_poc

class LoginUseCaseTests: XCTestCase {
    
    private var repository = MockLoginRepository()
    private lazy var sut = LoginUseCase(repository: self.repository)
    
    func testSuccessfulLogin() {
        // given
        let expected = LoginResponse(token: "local token")
        self.repository.loginResponseValue = .just(expected)
        
        // when
        let params = LoginUseCase.Params(email: "", password: "")
        let response = sut.execute(with: params)
        let result = response.toBlocking().materialize()
        
        // then
        switch result {
        case .completed: XCTAssert(true)
        case .failed: XCTFail("your test should complete")
        }
    }
    
    func testUnsuccessfulLogin() {
        // given
        let expected = NSError(domain: "", code: 0, userInfo: nil)
        self.repository.loginResponseValue = .error(expected)
        
        // when
        let params = LoginUseCase.Params(email: "", password: "")
        let response = sut.execute(with: params)
        let result = response.toBlocking().materialize()
        
        // then
        switch result {
        case .completed: XCTFail("your test should fail")
        case .failed: XCTAssert(true)
        }
    }
}
