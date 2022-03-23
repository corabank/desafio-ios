// For now will work as factory

import Foundation

final class TransactionRepository {
    func getTransactions(completion: @escaping (Result<[TransactionModel], Error>) -> Void) {
        var result: [TransactionModel] = []
        for count in 0 ..< 30 {
            result.append(TransactionModel(transactionDate: Date().addingTimeInterval(Double.random(in: 0 ..< 99999999)),
                                           transactionName: "Name \(count)",
                                           transactionValue: "VALUE",
                                           taxValue: nil,
                                           taxDescription: nil,
                                           isInvoicePayment: false))
        }
        completion(.success(result))
    }
}
