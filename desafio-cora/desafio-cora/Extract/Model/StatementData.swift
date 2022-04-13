struct StatementData: Codable {
    var transactionDay: String
    var transactionTotalValue: String
    var transactions: [TransactionDetail]
}

struct TransactionDetail: Codable {
    var customerName: String
    var transactionType: String
    var transactionHour: String
    var transactionValue: Float
    var transactionComplete: Bool
}
