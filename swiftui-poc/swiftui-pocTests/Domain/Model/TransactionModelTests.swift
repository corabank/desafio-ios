import XCTest
@testable import swiftui_poc

class TransactionModelTests: XCTestCase {
    
    private let buyer = BuyerModel(name: "Caju Cacau",
                                   email: "cajucacau@labs.moip.com.br")
    private lazy var sut = TransactionModel(id: "f97f1882-01bb-4ec4-9ad6-fe4c29a0820d",
                                            value: 110.00,
                                            date: CachedDateFormatter.shared.parseFormat().date(from: "2021-13-03T13:28:39Z"),
                                            status: .paid,
                                            paymentMethod: .creditCard,
                                            taxes: 2.33,
                                            buyer: self.buyer)
    
    func testMappingFromEntity() {
        // given
        let buyer = BuyerEntity(name: "Caju Cacau",
                                email: "cajucacau@labs.moip.com.br")
        let transaction = TransactionEntity(id: "f97f1882-01bb-4ec4-9ad6-fe4c29a0820d",
                                            value: 110.00,
                                            date: "2021-13-03T13:28:39Z",
                                            status: "PAID",
                                            paymentMethod: "CREDIT_CARD",
                                            taxes: 2.33,
                                            buyer: buyer)
        
        // when
        let result = TransactionModel(mapping: transaction)
        
        // then
        XCTAssertEqual(result.id, sut.id)
        XCTAssertEqual(result.value, sut.value)
        XCTAssertEqual(result.date, sut.date)
        XCTAssertEqual(result.status, sut.status)
        XCTAssertEqual(result.paymentMethod, sut.paymentMethod)
        XCTAssertEqual(result.taxes, sut.taxes)
        XCTAssertEqual(result.buyer.name, sut.buyer.name)
        XCTAssertEqual(result.buyer.email, sut.buyer.email)
    }
}
