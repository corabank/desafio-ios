import XCTest
@testable import desafio_cora

final class ExtractCoordinatorTests: XCTestCase {
    private let viewController = ViewControllerSpy()
    private lazy var sut: ExtractCoordinator = {
        let coordinator = ExtractCoordinator()
        coordinator.viewController = viewController
        return coordinator
    }()
    
    func testPerform_ShouldPresentLoginScene() {
        sut.coordinateToExtractDetail(transaction: TransactionDetail(customerName: "",
                                                                     userSent: nil,
                                                                     userRecieved: nil,
                                                                     transactionHour: "",
                                                                     transactionValue: 0.0,
                                                                     transactionStatus: TransactionStatus(transactionType: .transfer,
                                                                                                          status: .future,
                                                                                                          transactionEntry: .output)),
                                      transactionDay: "")
        
        XCTAssertEqual(viewController.callShowViewControllerCount, 1)
        XCTAssertTrue(viewController.viewController is ExtractDetailViewController)
    }
}
