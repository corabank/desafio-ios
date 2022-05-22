@testable import Cora
import XCTest

private final class BankStatementPresenterSpy: BankStatementPresenting {
    private(set) var callPresentTransactionsCount = 0
    private(set) var callPresentTransactionDetailCount = 0
    
    private(set) var calledId: Int?
    
    func presentTransactions() {
        callPresentTransactionsCount += 1
    }
    
    func presentTransactionDetail(id: Int) {
        callPresentTransactionDetailCount += 1
        calledId = id
    }
}

private final class BankStatementServiceMock: BankStatementServicing {
    private(set) var callGetBankStatementDataCount = 0
    var bankStatementExpectedResult: [DailyTransactions] = []
    
    func getBankStatementData() -> [DailyTransactions] {
        callGetBankStatementDataCount += 1
        return bankStatementExpectedResult
    }
}

final class BankStatementInteractorTests: XCTestCase {
    private let dailyTransactionsMock: [DailyTransactions] = [.mock, .mock2]
    private let presenterSpy = BankStatementPresenterSpy()
    private lazy var serviceMock: BankStatementServiceMock = {
        let service = BankStatementServiceMock()
        service.bankStatementExpectedResult = dailyTransactionsMock
        return service
    }()
    
    private lazy var sut = BankStatementInteractor(service: serviceMock, presenter: presenterSpy)
    
    func testDayInfoForSection_ShouldReturnStatementHeaderContent() {
        let section = 1
        let expectedResult = StatementHeaderContent(dayInfo: dailyTransactionsMock[section].dayInfo)
        let headerContent = sut.dayInfo(for: section)
        
        XCTAssertEqual(headerContent.formattedDate, expectedResult.formattedDate)
        XCTAssertEqual(headerContent.dayBalance, expectedResult.dayBalance)
    }
    
    func testDidSelectTransaction_ShouldPresentTransactionDetailWithId() {
        let section = 0
        let index = 0
        sut.didSelectTransaction(section: section, at: index)
        
        XCTAssertEqual(presenterSpy.callPresentTransactionDetailCount, 1)
        XCTAssertEqual(presenterSpy.calledId, dailyTransactionsMock[section].transactions[index].id)
    }
    
    func testNumberOfDays_ShouldReturnDailyTransactionsCount() {
        let numberOfDays = sut.numberOfDays()
        
        XCTAssertEqual(numberOfDays, dailyTransactionsMock.count)
    }
    
    func testNumberOfTransactions_ShouldReturnTransactionsCount() {
        let section = 0
        let numberOfTransactions = sut.numberOfTransactions(at: section)
        
        XCTAssertEqual(numberOfTransactions, dailyTransactionsMock[section].transactions.count)
    }
    
    func testTransactionInfoForSectionAtIndex_ShouldReturnStatementItemContent() {
        let section = 0
        let index = 0
        let expectedResult = StatementItemContent(transaction: dailyTransactionsMock[section].transactions[index])
        let itemContent = sut.transactionInfo(section: section, at: index)
        
        XCTAssertEqual(expectedResult, itemContent)
    }
    
    func testSelectSegment_WhenIsAllSection_ShouldPresentAllDailyTransactions() {
        sut.selectSegment(at: 0)
        
        XCTAssertEqual(presenterSpy.callPresentTransactionsCount, 1)
        XCTAssertEqual(sut.segmentedDailyTransactions, dailyTransactionsMock)
    }
    
    func testSelectSegment_WhenIsInputSection_ShouldPresentOnlyInputTransactions() {
        sut.selectSegment(at: 1)
        
        XCTAssertEqual(presenterSpy.callPresentTransactionsCount, 1)
        XCTAssertTrue(sut.segmentedDailyTransactions.allSatisfy { $0.transactions.allSatisfy { $0.type == .input }})
    }
    
    func testSelectSegment_WhenIsOutputSection_ShouldPresentOnlyOutputOrReversedTransactions() {
        sut.selectSegment(at: 2)
        
        XCTAssertEqual(presenterSpy.callPresentTransactionsCount, 1)
        XCTAssertTrue(sut.segmentedDailyTransactions.allSatisfy { $0.transactions.allSatisfy { $0.type == .output || $0.type == .reversed }})
    }
    
    func testSelectSegment_WhenIsFutureSection_ShouldPresentOnlyScheduledTransactions() {
        sut.selectSegment(at: 3)
        
        XCTAssertEqual(presenterSpy.callPresentTransactionsCount, 1)
        XCTAssertTrue(sut.segmentedDailyTransactions.allSatisfy { $0.transactions.allSatisfy { $0.type == .scheduled }})
    }
}
