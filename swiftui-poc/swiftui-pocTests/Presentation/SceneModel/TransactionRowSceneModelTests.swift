import XCTest
@testable import swiftui_poc

class TransactionRowSceneModelTests: XCTestCase {
    
    private let sut = TransactionRowSceneModel(id: "f97f1882-01bb-4ec4-9ad6-fe4c29a0820d",
                                               value: "R$ 110,00",
                                               buyerEmail: "cajucacau@labs.moip.com.br",
                                               status: .paid,
                                               date: "13/10/21")
    
    func testMappingFromModel() {
        // given
        let buyer = BuyerModel(name: "Caju Cacau",
                               email: "cajucacau@labs.moip.com.br")
        let transaction = TransactionModel(id: "f97f1882-01bb-4ec4-9ad6-fe4c29a0820d",
                                           value: 110.00,
                                           date: CachedDateFormatter.shared.parseFormat().date(from: "2021-10-13T13:28:39Z"),
                                           status: .paid,
                                           paymentMethod: .creditCard,
                                           taxes: 2.33,
                                           buyer: buyer)
        
        // when
        let result = TransactionRowSceneModel(mapping: transaction)
        
        // then
//        XCTAssertEqual(result.id, sut.id)
//        XCTAssertEqual(result.value, sut.value)
//        XCTAssertEqual(result.buyerEmail, sut.buyerEmail)
//        XCTAssertEqual(result.status, sut.status)
//        XCTAssertEqual(result.date, sut.date)
    }
    
    func testMappingStatusFromModel() {
        // given
        let paid = TransactionModel.Status.paid
        let notPaid = TransactionModel.Status.notPaid
        let waiting = TransactionModel.Status.waitingPayment
        
        // when
        let paidResult = TransactionRowSceneModel.Status(mapping: paid)
        let notPaidResult = TransactionRowSceneModel.Status(mapping: notPaid)
        let waitingResult = TransactionRowSceneModel.Status(mapping: waiting)
        
        // then
        XCTAssertEqual(paidResult.localizedDescription, "Pago")
        XCTAssertEqual(paidResult.uiColor, UIColor(red: 0.31, green: 0.8, blue: 0.5, alpha: 1))
        XCTAssertEqual(notPaidResult.localizedDescription, "Não Pago")
        XCTAssertEqual(notPaidResult.uiColor, UIColor(red: 0.91, green: 0.14, blue: 0.18, alpha: 1))
        XCTAssertEqual(waitingResult.localizedDescription, "Aguardando")
        XCTAssertEqual(waitingResult.uiColor, UIColor(red: 0.08, green: 0.67, blue: 0.78, alpha: 1))
    }
}
