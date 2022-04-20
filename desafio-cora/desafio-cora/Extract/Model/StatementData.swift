struct StatementData: Decodable {
    let transactionDay: String
    let transactionTotalValue: Float
    let transactions: [TransactionDetail]
}

struct TransactionDetail: Decodable, Equatable {
    let customerName: String
    let userSent: UserData?
    let userRecieved: UserData?
    let transactionHour: String
    let transactionValue: Float
    let transactionStatus: TransactionStatus
}

struct TransactionStatus: Decodable, Equatable {
    let transactionType: TransactionType
    let status: Status
    let transactionEntry: TransactionEntry
}

struct UserData: Decodable, Equatable {
    let name: String
    let cpf: String
    let bank: String
    let agency: String
    let account: String
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

enum TransactionEntry: String, Decodable {
    case input = "INPUT"
    case output = "OUTPUT"
}
