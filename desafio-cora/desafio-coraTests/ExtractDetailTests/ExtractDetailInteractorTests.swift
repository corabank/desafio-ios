import XCTest
@testable import desafio_cora

private final class ExtractDetailPresenterSpy: ExtractDetailPresenting {
    var viewController: ExtractDetailDisplaying?
    
    private(set) var callDidNextStepCount = 0
    private(set) var contentAction: ExtractDetailAction?
    
    func didNextStep(action: ExtractDetailAction) {
        callDidNextStepCount += 1
        contentAction = action
    }
}


final class ExtractDetailInteractorTests: XCTestCase {
    private let presenterSpy = ExtractDetailPresenterSpy()
    private lazy var sut = ExtractDetailInteractor(presenter: presenterSpy,
                                                   transaction: TransactionDetail(customerName: "",
                                                                                  userSent: nil,
                                                                                  userRecieved: nil,
                                                                                  transactionHour: "",
                                                                                  transactionValue: 0.0,
                                                                                  transactionStatus: TransactionStatus(transactionType: .transfer,
                                                                                                                       status: .future,
                                                                                                                       transactionEntry: .output)),
                                                   transactionDay: "")
    
    func testDidNextStep_ShouldPresentShare() {
        sut.share()
        
        XCTAssertEqual(presenterSpy.callDidNextStepCount, 1)
        XCTAssertEqual(presenterSpy.contentAction, .share)
    }
    
    func testDidNextStep_ShouldPresentCancelTransaction() {
        sut.cancelTransaction()
        
        XCTAssertEqual(presenterSpy.callDidNextStepCount, 1)
        XCTAssertEqual(presenterSpy.contentAction, .cancelTransaction)
    }
}
