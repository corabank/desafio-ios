import XCTest
@testable import desafio_cora

private final class ExtractCoordinatorSpy: ExtractCoordinating {
    var viewController: UIViewController?
    
    private(set) var callPerformCount = 0
    private(set) var contentAction: ExtractAction?
    
    func perform(action: ExtractAction) {
        callPerformCount += 1
        contentAction = action
    }
    
    func coordinateToExtractDetail(transaction: TransactionDetail, transactionDay: String) {
        
    }
}

final class ExtractPresenterTests: XCTestCase {
    private lazy var coordinatorSpy = ExtractCoordinatorSpy()
    private lazy var sut = ExtractPresenter(coordinator: coordinatorSpy)
    
    func testPerform_ShouldPresentSignOut() {
        sut.didNextStep(action: .signOut)
        
        XCTAssertEqual(coordinatorSpy.callPerformCount, 1)
        XCTAssertEqual(coordinatorSpy.contentAction, .signOut)
    }
    
    func testPerform_ShouldPresentFilterScene() {
        sut.didNextStep(action: .filterScene)
        
        XCTAssertEqual(coordinatorSpy.callPerformCount, 1)
        XCTAssertEqual(coordinatorSpy.contentAction, .filterScene)
    }
}
