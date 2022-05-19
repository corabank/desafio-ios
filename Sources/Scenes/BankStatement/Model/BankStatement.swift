import Foundation

struct BankStatement: Decodable {
    let dailyTransations: [DailyTransactions]
}

struct DailyTransactions: Decodable {
    let dayInfo: DayInfo
    let transactions: [Transation]
}

struct DayInfo: Decodable {
    let date: Date
    let dayBalance: Double
}

struct Transation: Decodable {
    let id: Int
    let name: String
    let hour: String
    let value: Double
    let type: TransationType
    let method: TransationMethod
}

enum TransationType: String, Decodable {
    case input = "INPUT"
    case output = "OUTPUT"
    case reversed = "REVERSED"
    case scheduled = "SCHEDULED"
}

enum TransationMethod: String, Decodable {
    case billet = "BILLET"
    case payment = "PAYMENT"
    case tranfer = "TRANFER"
}

