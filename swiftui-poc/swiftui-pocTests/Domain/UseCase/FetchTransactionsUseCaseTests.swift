import XCTest
@testable import swiftui_poc

class FetchTransactionsUseCaseTests: XCTestCase {
    
    private var repository = MockTransactionRepository()
    private lazy var sut = FetchTransactionsUseCase(repository: self.repository)
    
    func testSuccessfulFetch() {
        // given
        let buyer = BuyerEntity(name: "Caju Cacau", email: "cajucacau@labs.moip.com.br")
        let transaction = TransactionEntity(id: "f97f1882-01bb-4ec4-9ad6-fe4c29a0820d",
                                            value: 110.00,
                                            date: "2021-13-03 13:54:20",
                                            status: "PAID",
                                            paymentMethod: "CREDIT_CARD",
                                            taxes: 2.33,
                                            buyer: buyer)
        let transactionResponse = TransactionResponse(transactions: [transaction])
        self.repository.transactionResponseValue = .just(transactionResponse)
        
        // when
        let response = sut.execute()
        
        // then
        let expected = TransactionModel(mapping: transaction)
        XCTAssertEqual(try response.toBlocking().first(), [expected])
    }
    
    func testUnsuccessfulFetch() {
        // given
        let expected = NSError(domain: "", code: 0, userInfo: nil)
        self.repository.transactionResponseValue = .error(expected)
        
        // when
        let response = sut.execute()
        
        // then
        XCTAssertThrowsError(try response.toBlocking().first())
    }
    
    func testFilteringStatus() {
        // given
        let buyer = BuyerEntity(name: "Caju Cacau", email: "cajucacau@labs.moip.com.br")
        let transaction1 = TransactionEntity(id: "f97f1882-01bb-4ec4-9ad6-fe4c29a0820d",
                                             value: 110.00,
                                             date: "2021-13-03 13:54:20",
                                             status: "",
                                             paymentMethod: "CREDIT_CARD",
                                             taxes: 2.33,
                                             buyer: buyer)
        let transaction2 = TransactionEntity(id: "f97f1882-01bb-4ec4-9ad6-fe4c29a0820d",
                                             value: 110.00,
                                             date: "2021-13-03 13:54:20",
                                             status: "PAID",
                                             paymentMethod: "CREDIT_CARD",
                                             taxes: 2.33,
                                             buyer: buyer)
        let transactionResponse = TransactionResponse(transactions: [transaction1, transaction2])
        self.repository.transactionResponseValue = .just(transactionResponse)
        
        // when
        let response = sut.execute()
        
        // then
        let expected = TransactionModel(mapping: transaction2)
        XCTAssertEqual(try response.toBlocking().first(), [expected])
        XCTAssertEqual(try response.toBlocking().first()?.count, 1)
    }
    
    func testFilteringPaymentMethod() {
        // given
        let buyer = BuyerEntity(name: "Caju Cacau", email: "cajucacau@labs.moip.com.br")
        let transaction1 = TransactionEntity(id: "f97f1882-01bb-4ec4-9ad6-fe4c29a0820d",
                                             value: 110.00,
                                             date: "2021-13-03 13:54:20",
                                             status: "PAID",
                                             paymentMethod: "CREDIT_CARD",
                                             taxes: 2.33,
                                             buyer: buyer)
        let transaction2 = TransactionEntity(id: "f97f1882-01bb-4ec4-9ad6-fe4c29a0820d",
                                             value: 110.00,
                                             date: "2021-13-03 13:54:20",
                                             status: "PAID",
                                             paymentMethod: "",
                                             taxes: 2.33,
                                             buyer: buyer)
        let transactionResponse = TransactionResponse(transactions: [transaction1, transaction2])
        self.repository.transactionResponseValue = .just(transactionResponse)
        
        // when
        let response = sut.execute()
        
        // then
        let expected = TransactionModel(mapping: transaction1)
        XCTAssertEqual(try response.toBlocking().first(), [expected])
        XCTAssertEqual(try response.toBlocking().first()?.count, 1)
    }
}
