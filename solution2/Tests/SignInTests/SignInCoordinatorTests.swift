@testable import Cora
import XCTest

final class SignInCoordinatorTests: XCTestCase {
    private let viewControllerSpy = ViewControllerSpy()
    private lazy var sut: SignInCoordinator = {
        let coordinator = SignInCoordinator()
        coordinator.viewController = viewControllerSpy
        return coordinator
    }()
    
    func testCoordinateToPasswordScene_ShouldCallPasswordScene() {
        sut.coordinateToPasswordScene()
        
        XCTAssertEqual(viewControllerSpy.callShowCount, 1)
        XCTAssertTrue(viewControllerSpy.shownViewController is PasswordViewController)
    }
}
