import XCTest
@testable import desafio_cora

private final class PasswordPresenterSpy: PasswordPresenting {
    var viewController: PasswordDisplaying?
    
    private(set) var callDidNextStepCount = 0
    private(set) var contentAction: PasswordAction?
    
    func didNextStep(action: PasswordAction) {
        callDidNextStepCount += 1
        contentAction = action
    }
}


final class PasswordInteractorTests: XCTestCase {
    private let presenterSpy = PasswordPresenterSpy()
    private lazy var sut = PasswordInteractor(presenter: presenterSpy)
    
    func testDidNextStep_ShouldPresentLostPassword() {
        sut.lostPassword()
        
        XCTAssertEqual(presenterSpy.callDidNextStepCount, 1)
        XCTAssertEqual(presenterSpy.contentAction, .lostPassword)
    }
    
    func testDidNextStep_ShouldPresentExtractScene() {
        sut.extractScene()
        
        XCTAssertEqual(presenterSpy.callDidNextStepCount, 1)
        XCTAssertEqual(presenterSpy.contentAction, .extractScene)
    }
}
