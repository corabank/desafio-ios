@testable import Cora
import XCTest

private final class HomePresenterSpy: HomePresenting {
    private(set) var callPresentSignInSceneCount = 0
    
    func presentSignInScene() {
        callPresentSignInSceneCount += 1
    }
}

final class HomeInteractorTests: XCTestCase {
    private let presenterSpy = HomePresenterSpy()
    private lazy var sut = HomeInteractor(presenter: presenterSpy)
    
    func testGoSignInScene_ShouldCallPresentSignInScene() {
        sut.goSignInScene()
        XCTAssertEqual(presenterSpy.callPresentSignInSceneCount, 1)
    }
}
