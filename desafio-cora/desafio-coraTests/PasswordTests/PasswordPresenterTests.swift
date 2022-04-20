import XCTest
@testable import desafio_cora

private final class PasswordCoordinatorSpy: PasswordCoordinating {
    var viewController: UIViewController?
    
    private(set) var callPerformCount = 0
    private(set) var contentAction: PasswordAction?
    
    func perform(action: PasswordAction) {
        callPerformCount += 1
        contentAction = action
    }
}

final class PasswordPresenterTests: XCTestCase {
    private lazy var coordinatorSpy = PasswordCoordinatorSpy()
    private lazy var sut = PasswordPresenter(coordinator: coordinatorSpy)
    
    func testPerform_ShouldPresentLostPassword() {
        sut.didNextStep(action: .lostPassword)
        
        XCTAssertEqual(coordinatorSpy.callPerformCount, 1)
        XCTAssertEqual(coordinatorSpy.contentAction, .lostPassword)
    }
    
    func testPerform_ShouldPresentExtractScene() {
        sut.didNextStep(action: .extractScene)
        
        XCTAssertEqual(coordinatorSpy.callPerformCount, 1)
        XCTAssertEqual(coordinatorSpy.contentAction, .extractScene)
    }
}
