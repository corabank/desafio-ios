import XCTest
@testable import swiftui_poc

class LoginViewModelTests: XCTestCase {
    
    private let useCase = MockLoginUseCase()
    private let coordinator = MockLoginCoordinator()
    private lazy var sut = LoginViewModel(loginUseCase: self.useCase, coordinator: self.coordinator)
    
    func testDefaultInit() {
        XCTAssertEqual(sut.state, .initial)
        
        XCTAssert(sut.attributes.email.isEmpty)
        XCTAssert(sut.attributes.password.isEmpty)
        
        XCTAssertFalse(sut.canSubmit)
    }
    
    func testSuccessfulLogin() {
        // given
        sut.attributes.email = "email@email.com"
        sut.attributes.password = "password"
        
        XCTAssertTrue(sut.canSubmit)
        
        // when
        useCase.completableValue = .empty()
        sut.login()
        _ = useCase.execute(with: nil).toBlocking()
        
        // then
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            XCTAssertEqual(self.sut.state, .loaded)
        }
    }
    
    func testUnsuccessfulLogin() {
        // given
        sut.attributes.email = "email@email.com"
        sut.attributes.password = "password"
        
        XCTAssertTrue(sut.canSubmit)
        
        // when
        let exception = NSError(domain: "", code: 0, userInfo: nil)
        useCase.completableValue = .error(exception)
        sut.login()
        _ = useCase.execute(with: nil).toBlocking()
        
        // then
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            XCTAssertEqual(self.sut.state, .error)
        }
    }
}
