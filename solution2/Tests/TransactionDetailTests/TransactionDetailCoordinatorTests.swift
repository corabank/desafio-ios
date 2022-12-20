@testable import Cora
import XCTest

final class TransactionDetailCoordinatorTests: XCTestCase {
    private let viewControllerSpy = ViewControllerSpy()
    private lazy var sut: TransactionDetailCoordinator = {
        let coordinator = TransactionDetailCoordinator()
        coordinator.viewController = viewControllerSpy
        return coordinator
    }()
    
    func testCoordinateToTransactionDetail_ShouldTransactionDetailScene() {
        sut.coordinateToActivityController(shareItem: UIImage())
        
        XCTAssertEqual(viewControllerSpy.callPresentCount, 1)
        XCTAssertTrue(viewControllerSpy.viewControllerToPresent is UIActivityViewController)
    }
}
