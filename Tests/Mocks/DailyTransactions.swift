@testable import Cora

extension DailyTransactions {
    static let mock = DailyTransactions(dayInfo: .mock, transactions: [.mock, .mock2, .mock3])
    static let mock2 = DailyTransactions(dayInfo: .mock2, transactions: [.mock4])
}
