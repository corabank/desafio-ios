import XCTest
@testable import swiftui_poc

class TransactionSpecsTests: XCTestCase {
    
    // Request unit test is avoided
    private let buyer = BuyerEntity(name: "Caju Cacau", email: "cajucacau@labs.moip.com.br")
    private lazy var transaction = TransactionEntity(id: "f97f1882-01bb-4ec4-9ad6-fe4c29a0820d",
                                                     value: 110.00,
                                                     date: "2021-13-03 13:54:20",
                                                     status: "PAID",
                                                     paymentMethod: "CREDIT_CARD",
                                                     taxes: 2.33,
                                                     buyer: self.buyer)
    private lazy var responseSUT = TransactionResponse(transactions: [self.transaction])
    
    func testDefaultResponseInit() {
        let result = responseSUT.transactions.first
        
        XCTAssertEqual(result?.id, transaction.id)
        XCTAssertEqual(result?.value, transaction.value)
        XCTAssertEqual(result?.date, transaction.date)
        XCTAssertEqual(result?.status, transaction.status)
        XCTAssertEqual(result?.paymentMethod, transaction.paymentMethod)
        XCTAssertEqual(result?.taxes, transaction.taxes)
        XCTAssertEqual(result?.buyer.name, transaction.buyer.name)
        XCTAssertEqual(result?.buyer.email, transaction.buyer.email)
    }
}
