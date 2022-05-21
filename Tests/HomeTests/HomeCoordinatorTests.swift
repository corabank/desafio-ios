@testable import Cora
import XCTest

final class HomeCoordinatorTests: XCTestCase {
    private let viewControllerSpy = ViewControllerSpy()
    private lazy var sut: HomeCoordinator = {
        let coordinator = HomeCoordinator()
        coordinator.viewController = viewControllerSpy
        return coordinator
    }()
    
    func testCoordinateToSignInScene_ShouldCallSignInScene() {
        sut.coordinateToSignInScene()
        
        XCTAssertEqual(viewControllerSpy.callShowCount, 1)
        XCTAssertTrue(viewControllerSpy.shownViewController is SignInViewController)
    }
}
