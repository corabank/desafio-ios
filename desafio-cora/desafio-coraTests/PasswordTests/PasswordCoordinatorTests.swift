import XCTest
@testable import desafio_cora

final class PasswordCoordinatorTests: XCTestCase {
    private let viewController = ViewControllerSpy()
    private lazy var sut: PasswordCoordinator = {
        let coordinator = PasswordCoordinator()
        coordinator.viewController = viewController
        return coordinator
    }()
    
    func testPerform_ShouldPresentLoginScene() {
        sut.perform(action: .extractScene)
        
        XCTAssertEqual(viewController.callShowViewControllerCount, 1)
        XCTAssertTrue(viewController.viewController is ExtractViewController)
    }
}
