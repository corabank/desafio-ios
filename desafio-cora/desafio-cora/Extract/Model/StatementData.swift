struct StatementData: Decodable {
    let transactionDay: String
    let transactionTotalValue: Float
    let transactions: [TransactionDetail]
}

struct TransactionDetail: Decodable {
    let customerName: String
    let transactionHour: String
    let transactionValue: Float
    let transactionStatus: TransactionStatus
}

struct TransactionStatus: Decodable {
    let transactionType: TransactionType
    let status: Status
    let transactionEntry: TransactionEntry
}

enum TransactionType: String, Decodable {
    case transfer = "TRANSFER"
    case ticket = "TICKET"
    case payment = "PAYMENT"
}

enum Status: String, Decodable {
    case complete = "COMPLETE"
    case reversed = "REVERSED"
    case future = "FUTURE"
}

enum TransactionEntry:String, Decodable {
    case input = "INPUT"
    case output = "OUTPUT"
}
