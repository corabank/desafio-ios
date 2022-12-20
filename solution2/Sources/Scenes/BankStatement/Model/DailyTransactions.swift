import Foundation

struct DailyTransactions: Decodable, Equatable {
    let dayInfo: DayInfo
    let transactions: [Transaction]
}

struct DayInfo: Decodable, Equatable {
    let date: Date
    let dayBalance: Double
}

struct Transaction: Decodable, Equatable {
    let id: Int
    let name: String
    let hour: String
    let value: Double
    let type: TransactionType
    let method: TransactionMethod
}

enum TransactionType: String, Decodable {
    case input = "INPUT"
    case output = "OUTPUT"
    case reversed = "REVERSED"
    case scheduled = "SCHEDULED"
}

enum TransactionMethod: String, Decodable {
    case billet = "BILLET"
    case payment = "PAYMENT"
    case transfer = "TRANSFER"
}

