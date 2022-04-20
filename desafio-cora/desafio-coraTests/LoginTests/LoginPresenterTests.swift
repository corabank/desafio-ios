import XCTest
@testable import desafio_cora

private final class LoginCoordinatorSpy: LoginCoordinating {
    var viewController: UIViewController?

    private(set) var callCoordinateToPasswordSceneCount = 0

    func coordinateToPasswordScene() {
        callCoordinateToPasswordSceneCount += 1
    }
}

final class LoginPresenterTests: XCTestCase {
    private lazy var coordinatorSpy = LoginCoordinatorSpy()
    private lazy var sut = LoginPresenter(coordinator: coordinatorSpy)
    
    func testCoordinateToPasswordScene_ShouldPresentPasswordScene() {
        sut.presentPasswordScene()
        
        XCTAssertEqual(coordinatorSpy.callCoordinateToPasswordSceneCount, 1)
    }
}
