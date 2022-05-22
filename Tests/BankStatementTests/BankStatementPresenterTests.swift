@testable import Cora
import XCTest

private final class BankStatementCoordinatorSpy: BankStatementCoordinating {
    private(set) var callCoordinateToTransactionDetailSceneCount = 0
    private(set) var calledId: Int?
    
    func coordinateToTransactionDetail(id: Int) {
        callCoordinateToTransactionDetailSceneCount += 1
        calledId = id
    }
}

private final class BankStatementViewControllerSpy: BankStatementDisplaying {
    private(set) var callDisplayTransactionsCount = 0
    
    func displayTransactions() {
        callDisplayTransactionsCount += 1
    }
}

final class BankStatementPresenterTests: XCTestCase {
    private let coordinatorSpy = BankStatementCoordinatorSpy()
    private let viewControllerSpy = BankStatementViewControllerSpy()
    private lazy var sut: BankStatementPresenter = {
        let presenter = BankStatementPresenter(coordinator: coordinatorSpy)
        presenter.viewController = viewControllerSpy
        return presenter
    }()
    
    func testPresentTransactions_ShouldCallDisplayTransactions() {
        sut.presentTransactions()
        
        XCTAssertEqual(viewControllerSpy.callDisplayTransactionsCount, 1)
    }
    
    func testPresentTransactionDetail_ShouldCallCoordinateToTransactionDetailSceneWithId() {
        let id = 1
        sut.presentTransactionDetail(id: id)
        
        XCTAssertEqual(coordinatorSpy.callCoordinateToTransactionDetailSceneCount, 1)
        XCTAssertEqual(coordinatorSpy.calledId, 1)
    }
}
