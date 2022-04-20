import XCTest
@testable import desafio_cora

private final class HomeCoordinatorSpy: HomeCoordinating {
    var viewController: UIViewController?
    
    private(set) var callPerformCount = 0
    private(set) var contentAction: HomeAction?
    
    func perform(action: HomeAction) {
        callPerformCount += 1
        contentAction = action
    }
}

final class HomePresenterTests: XCTestCase {
    private lazy var coordinatorSpy = HomeCoordinatorSpy()
    private lazy var sut = HomePresenter(coordinator: coordinatorSpy)
    
    func testPerform_ShouldPresentLoginScene() {
        sut.didNextStep(action: .login)
        
        XCTAssertEqual(coordinatorSpy.callPerformCount, 1)
        XCTAssertEqual(coordinatorSpy.contentAction, .login)
    }
    
    func testPerform_ShouldPresentSignUpScene() {
        sut.didNextStep(action: .signUp)
        
        XCTAssertEqual(coordinatorSpy.callPerformCount, 1)
        XCTAssertEqual(coordinatorSpy.contentAction, .signUp)
    }
}
