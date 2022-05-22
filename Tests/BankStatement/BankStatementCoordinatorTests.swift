@testable import Cora
import XCTest

final class BankStatementCoordinatorTests: XCTestCase {
    private let viewControllerSpy = ViewControllerSpy()
    private lazy var sut: BankStatementCoordinator = {
        let coordinator = BankStatementCoordinator()
        coordinator.viewController = viewControllerSpy
        return coordinator
    }()
    
    func testCoordinateToTransactionDetail_ShouldTransactionDetailScene() {
        sut.coordinateToTransactionDetail(id: 1)
        
        XCTAssertEqual(viewControllerSpy.callShowCount, 1)
        XCTAssertTrue(viewControllerSpy.shownViewController is TransactionDetailViewController)
    }
}
