@testable import Cora
import XCTest

private final class TransactionDetailPresenterSpy: TransactionDetailPresenting {
    private(set) var callPresentContentCount = 0
    private(set) var callPresentActivityControllerCount = 0
    
    private(set) var calledShareItem: UIImage?
    private(set) var calledTransactionDetail: TransactionDetail?
    
    func presentContent(transactionDetail: TransactionDetail) {
        callPresentContentCount += 1
        calledTransactionDetail = transactionDetail
    }
    
    func presentActivityController(shareItem: UIImage) {
        callPresentActivityControllerCount += 1
        calledShareItem = shareItem
    }
}

private final class TransactionDetailServiceMock: TransactionDetailServicing {
    private(set) var callGetTransactionDetailDataCount = 0
    var transactionDetailExpectedResult: TransactionDetail?
    
    func getTransactionDetailData(id: Int) -> TransactionDetail? {
        callGetTransactionDetailDataCount += 1
        return transactionDetailExpectedResult
    }
}

final class TransactionDetailInteractorTests: XCTestCase {
    private let transactionId = 1
    private let presenterSpy = TransactionDetailPresenterSpy()
    private lazy var serviceMock: TransactionDetailServiceMock = {
        let service = TransactionDetailServiceMock()
        service.transactionDetailExpectedResult = .mock
        return service
    }()
    
    private lazy var sut = TransactionDetailInteractor(service: serviceMock,
                                                       presenter: presenterSpy,
                                                       transactionId: transactionId)
    
    func testFetchContent_ShouldCallPresentCount() {
        sut.fetchContent()
        
        XCTAssertEqual(serviceMock.callGetTransactionDetailDataCount, 1)
        XCTAssertEqual(presenterSpy.callPresentContentCount, 1)
        XCTAssertEqual(presenterSpy.calledTransactionDetail, .mock)
    }
    
    func testShareRceipt_ShouldCallPresentActivityControllerWithShareItem() {
        let image = UIImage()
        sut.share(receipt: image)
        
        XCTAssertEqual(presenterSpy.callPresentActivityControllerCount, 1)
        XCTAssertEqual(presenterSpy.calledShareItem, image)
    }
}
