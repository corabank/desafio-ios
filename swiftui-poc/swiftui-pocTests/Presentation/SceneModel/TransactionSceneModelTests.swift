import XCTest
@testable import swiftui_poc

class TransactionSceneModelTests: XCTestCase {
    
    private let sut = TransactionSceneModel(id: "f97f1882-01bb-4ec4-9ad6-fe4c29a0820d",
                                            value: "R$ 110,00",
                                            buyer: BuyerSceneModel(name: "Caju Cacau", email: "cajucacau@labs.moip.com.br"),
                                            paymentMethod: .creditCard,
                                            date: "13/10/21",
                                            status: .paid,
                                            taxes: "R$ 2,33")
    
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
        let result = TransactionSceneModel(mapping: transaction)
        
        // then
        XCTAssertEqual(result?.id, sut.id)
//        XCTAssertEqual(result?.value, sut.value)
        XCTAssertEqual(result?.buyer, sut.buyer)
        XCTAssertEqual(result?.paymentMethod, sut.paymentMethod)
        XCTAssertEqual(result?.date, sut.date)
        XCTAssertEqual(result?.status, sut.status)
//        XCTAssertEqual(result?.taxes, sut.taxes)
    }
    
    func testMappingStatusFromModel() {
        // given
        let paid = TransactionModel.Status.paid
        let notPaid = TransactionModel.Status.notPaid
        let waiting = TransactionModel.Status.waitingPayment
        
        // when
        let paidResult = TransactionSceneModel.Status(mapping: paid)
        let notPaidResult = TransactionSceneModel.Status(mapping: notPaid)
        let waitingResult = TransactionSceneModel.Status(mapping: waiting)
        
        // then
        XCTAssertEqual(paidResult.localizedDescription, "Pago")
        XCTAssertEqual(paidResult.uiColor, UIColor(red: 0.31, green: 0.8, blue: 0.5, alpha: 1))
        XCTAssertEqual(notPaidResult.localizedDescription, "Não Pago")
        XCTAssertEqual(notPaidResult.uiColor, UIColor(red: 0.91, green: 0.14, blue: 0.18, alpha: 1))
        XCTAssertEqual(waitingResult.localizedDescription, "Aguardando")
        XCTAssertEqual(waitingResult.uiColor, UIColor(red: 0.08, green: 0.67, blue: 0.78, alpha: 1))
    }
    
    func testMappingPaymentFromModel() {
        // given
        let cash = TransactionModel.PaymentMethod.cash
        let creditCard = TransactionModel.PaymentMethod.creditCard
        
        // when
        let cashResult = TransactionSceneModel.PaymentMethod(mapping: cash)
        let creditCardResult = TransactionSceneModel.PaymentMethod(mapping: creditCard)
        
        // then
        XCTAssertEqual(cashResult.localizedDescription, "Dinheiro")
        XCTAssertEqual(creditCardResult.localizedDescription, "Cartão de Crédito")
    }
}
