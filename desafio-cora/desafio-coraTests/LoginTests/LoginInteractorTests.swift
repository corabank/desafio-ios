import XCTest
@testable import desafio_cora

private final class LoginPresenterSpy: LoginPresenting {
    var viewController: LoginDisplaying?
    
    private(set) var callPresentPasswordSceneCount = 0
    
    func presentPasswordScene() {
        callPresentPasswordSceneCount += 1
    }
}


final class LoginInteractorTests: XCTestCase {
    private let presenterSpy = LoginPresenterSpy()
    private lazy var sut = LoginInteractor(presenter: presenterSpy)
    
    func testPresentPasswordScene_ShouldPresentPasswordScene() {
        sut.passwordScene()
        
        XCTAssertEqual(presenterSpy.callPresentPasswordSceneCount, 1)
    }
}
