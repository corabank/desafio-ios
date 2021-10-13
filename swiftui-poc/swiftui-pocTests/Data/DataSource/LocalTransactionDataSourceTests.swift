import XCTest
import RxBlocking
@testable import swiftui_poc

class LocalTransactionDataSourceTests: XCTestCase {
    
    private var manager = MockLocalFileReader()
    private lazy var sut = LocalTransactionDataSource(manager: self.manager)
    
    func testSuccessfulPerformLogin() {
        // given
        let buyer = BuyerEntity(name: "Caju Cacau", email: "cajucacau@labs.moip.com.br")
        let transaction = TransactionEntity(id: "f97f1882-01bb-4ec4-9ad6-fe4c29a0820d",
                                            value: 110.00,
                                            date: "2021-13-03T13:54:20Z",
                                            status: "PAID",
                                            paymentMethod: "CREDIT_CARD",
                                            taxes: 2.33,
                                            buyer: buyer)
        let expected = TransactionResponse(transactions: [transaction])
        self.manager.requestReturnValue = .just(expected)
        
        // when
        let response = self.sut.retrieveTransactions()
        
        // then
        XCTAssertEqual(try response.toBlocking().first(), expected)
    }
    
    func testUnsuccessfulPerformLogin() {
        // given
        let expected = NSError(domain: "", code: 0, userInfo: nil)
        self.manager.requestReturnValue = .error(expected)
            
        // when
        let response = self.sut.retrieveTransactions()
        
        // then
        XCTAssertThrowsError(try response.toBlocking().first())
    }
}
