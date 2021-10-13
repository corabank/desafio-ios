import Foundation
import RxSwift
@testable import swiftui_poc

struct MockTransactionRepository: TransactionRepository {
    
    var transactionResponseValue: Single<TransactionResponse>!
    func retrieveTransactions() -> Single<TransactionResponse> {
        return transactionResponseValue
    }
}
