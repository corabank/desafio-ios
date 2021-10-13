import Foundation

struct TransactionModel {
    private(set) var id: String
    private(set) var value: Float
    private(set) var date: Date?
    private(set) var status: Status
    private(set) var paymentMethod: PaymentMethod
    private(set) var taxes: Float
    private(set) var buyer: BuyerModel
}

extension TransactionModel {
    
    enum Status: String {
        case unkown
        case paid = "PAID"
        case notPaid = "NOT_PAID"
        case waitingPayment = "WAITING_PAYMENT"
    }
    
    enum PaymentMethod: String {
        case unkown
        case creditCard = "CREDIT_CARD"
        case cash = "CASH"
    }
}

extension TransactionModel {
    init(mapping entity: TransactionEntity) {
        self.id = entity.id
        self.value = entity.value
        self.date = CachedDateFormatter.shared.parseFormat().date(from: entity.date)
        self.status = Status(rawValue: entity.status) ?? .unkown
        self.paymentMethod = PaymentMethod(rawValue: entity.paymentMethod) ?? .unkown
        self.taxes = entity.taxes
        self.buyer = BuyerModel(mapping: entity.buyer)
    }
}
