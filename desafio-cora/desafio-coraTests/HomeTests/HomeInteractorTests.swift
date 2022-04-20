import XCTest
@testable import desafio_cora

private final class HomePresenterSpy: HomePresenting {
    private(set) var callDidNextStepCount = 0
    private(set) var contentAction: HomeAction?
    
    var viewController: HomeDisplaying?
    
    func didNextStep(action: HomeAction) {
        callDidNextStepCount += 1
        contentAction = action
    }
}


final class HomeInteractorTests: XCTestCase {
    private let presenterSpy = HomePresenterSpy()
    private lazy var sut = HomeInteractor(presenter: presenterSpy)
    
    func testDidNextStep_ShouldPresentLoginScene() {
        sut.loginScene()
        
        XCTAssertEqual(presenterSpy.callDidNextStepCount, 1)
        XCTAssertEqual(presenterSpy.contentAction, .login)
    }
    
    func testDidNextStep_ShouldPresentSignUpScene() {
        sut.signUpScene()
        
        XCTAssertEqual(presenterSpy.callDidNextStepCount, 1)
        XCTAssertEqual(presenterSpy.contentAction, .signUp)
    }
}
