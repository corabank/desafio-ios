import XCTest
@testable import desafio_cora

final class HomeCoordinatorTests: XCTestCase {
    private let viewController = ViewControllerSpy()
    private lazy var sut: HomeCoordinator = {
        let coordinator = HomeCoordinator()
        coordinator.viewController = viewController
        return coordinator
    }()
    
    func testPerform_ShouldPresentLoginScene() {
        sut.perform(action: .login)
        
        XCTAssertEqual(viewController.callShowViewControllerCount, 1)
        XCTAssertTrue(viewController.viewController is LoginViewController)
    }
}
