import Foundation

struct TransactionModel {
    let transactionDate: Date
    let transactionName: String
    let transactionValue: String
    let taxValue: String?
    let taxDescription: String?
    let isInvoicePayment: Bool
}
