import XCTest
@testable import desafio_cora

final class LoginCoordinatorTests: XCTestCase {
    private let viewController = ViewControllerSpy()
    private lazy var sut: LoginCoordinator = {
        let coordinator = LoginCoordinator()
        coordinator.viewController = viewController
        return coordinator
    }()
    
    func testPerform_ShouldPresentLoginScene() {
        sut.coordinateToPasswordScene()
        
        XCTAssertEqual(viewController.callShowViewControllerCount, 1)
        XCTAssertTrue(viewController.viewController is PasswordViewController)
    }
}
