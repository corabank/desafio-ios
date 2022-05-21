@testable import Cora
import XCTest

private final class HomeCoordinatorSpy: HomeCoordinating {
    private(set) var callCoordinateToSignInSceneCount = 0
    
    func coordinateToSignInScene() {
        callCoordinateToSignInSceneCount += 1
    }
}

final class HomePresenterTests: XCTestCase {
    private let coordinatorSpy = HomeCoordinatorSpy()
    private lazy var sut = HomePresenter(coordinator: coordinatorSpy)
    
    func testPresentSignInScene_ShouldCoordinateToSignInScene() {
        sut.presentSignInScene()
        
        XCTAssertEqual(coordinatorSpy.callCoordinateToSignInSceneCount, 1)
    }
}
