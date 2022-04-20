import XCTest
@testable import desafio_cora

private final class ExtractServiceMock: ExtractServicing {
    var fetchOfferExpectedResult: Result<[StatementData], Error>?
    let data = [StatementData(transactionDay: "Ontem - 5 de Agosto",
                              transactionTotalValue: 3124.34,
                              transactions: [TransactionDetail(customerName: "Judith Cooper",
                                                               userSent: nil,
                                                               userRecieved: nil,
                                                               transactionHour: "09:22",
                                                               transactionValue: 26.00,
                                                               transactionStatus: TransactionStatus(transactionType: .transfer,
                                                                                                    status: .complete,
                                                                                                    transactionEntry: .input)
                                                              )
                                            ]
                             )
        ]
    
    func loadData() -> [StatementData] {
        return data
    }
}

private final class ExtractPresenterSpy: ExtractPresenting {
    var viewController: ExtractDisplaying?
    
    private(set) var callDisplayStatementListCount = 0
    private(set) var callDidNextStepCount = 0
    private(set) var callPresentExtractDetailCount = 0
    private(set) var contentTransaction: TransactionDetail?
    private(set) var contentTransactionDay: String?
    private(set) var contentAction: ExtractAction?
    
    func displayStatementList() {
        callDisplayStatementListCount += 1
    }
    
    func didNextStep(action: ExtractAction) {
        callDidNextStepCount += 1
        contentAction = action
    }
    
    func presentExtractDetail(transaction: TransactionDetail, transactionDay: String) {
        callPresentExtractDetailCount += 1
        contentTransaction = transaction
        contentTransactionDay = transactionDay
    }
}


final class ExtractInteractorTests: XCTestCase {
    private let serviceMock = ExtractServiceMock()
    private let presenterSpy = ExtractPresenterSpy()
    private lazy var sut = ExtractInteractor(service: serviceMock, presenter: presenterSpy)
    
    func testFilterData() {
        sut.getExtractData()
        sut.filterData(index: 2)
        
        XCTAssertEqual(presenterSpy.callDisplayStatementListCount, 1)
    }
    
    func testSectionCount() {
        sut.getExtractData()
        let sectionCount = sut.sectionCount()
        
        XCTAssertEqual(sut.filterStatementData.count, sectionCount)
    }
    
    func testDidNextStep_ShouldPresentLostPassword() {
        sut.signOut()
        
        XCTAssertEqual(presenterSpy.callDidNextStepCount, 1)
        XCTAssertEqual(presenterSpy.contentAction, .signOut)
    }
    
    func testDidNextStep_ShouldPresentShowFilter() {
        sut.showFilter()
        
        XCTAssertEqual(presenterSpy.callDidNextStepCount, 1)
        XCTAssertEqual(presenterSpy.contentAction, .filterScene)
    }
    
    func testDidNextStep_ShouldPresentExtractDetail() {
        sut.getExtractData()
        sut.filterData(index: 0)
        let index = IndexPath(row: 0, section: 0)
        sut.goToExtractDetail(indexPath: index)

        XCTAssertEqual(presenterSpy.callPresentExtractDetailCount, 1)
        XCTAssertEqual(presenterSpy.contentTransaction, serviceMock.data[index.section].transactions[index.row])
        XCTAssertEqual(presenterSpy.contentTransactionDay, serviceMock.data[index.section].transactionDay)
    }
}
