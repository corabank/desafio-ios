import XCTest
@testable import desafio_cora

private final class ExtractDetailCoordinatorSpy: ExtractDetailCoordinating {
    var viewController: UIViewController?
    
    private(set) var callPerformCount = 0
    private(set) var contentAction: ExtractDetailAction?
    
    func perform(action: ExtractDetailAction) {
        callPerformCount += 1
        contentAction = action
    }
}

final class ExtractDetailPresenterTests: XCTestCase {
    private lazy var coordinatorSpy = ExtractDetailCoordinatorSpy()
    private lazy var sut = ExtractDetailPresenter(coordinator: coordinatorSpy)
    
    func testPerform_ShouldPresentShare() {
        sut.didNextStep(action: .share)
        
        XCTAssertEqual(coordinatorSpy.callPerformCount, 1)
        XCTAssertEqual(coordinatorSpy.contentAction, .share)
    }
    
    func testPerform_ShouldPresentCancelTransaction() {
        sut.didNextStep(action: .cancelTransaction)
        
        XCTAssertEqual(coordinatorSpy.callPerformCount, 1)
        XCTAssertEqual(coordinatorSpy.contentAction, .cancelTransaction)
    }
}
