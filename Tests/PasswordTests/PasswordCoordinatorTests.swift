@testable import Cora
import XCTest

final class PasswordCoordinatorTests: XCTestCase {
    private let viewControllerSpy = ViewControllerSpy()
    private lazy var sut: PasswordCoordinator = {
        let coordinator = PasswordCoordinator()
        coordinator.viewController = viewControllerSpy
        return coordinator
    }()
    
    func testCoordinateToBankStatement_ShouldBankStatementScene() {
        sut.coordinateToBankStatement()
        
        XCTAssertEqual(viewControllerSpy.callShowCount, 1)
        XCTAssertTrue(viewControllerSpy.shownViewController is BankStatementViewController)
    }
}
