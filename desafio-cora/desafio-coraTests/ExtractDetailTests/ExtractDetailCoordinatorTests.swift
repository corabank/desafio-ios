import XCTest
@testable import desafio_cora

final class ExtractDetailCoordinatorTests: XCTestCase {
    private let viewController = ViewControllerSpy()
    private lazy var sut: ExtractDetailCoordinator = {
        let coordinator = ExtractDetailCoordinator()
        coordinator.viewController = viewController
        return coordinator
    }()
    
    func testPerform_ShouldPresentLoginScene() {
        sut.perform(action: .share)
        
        XCTAssertEqual(viewController.callPresentViewControllerCount, 1)
    }
}
