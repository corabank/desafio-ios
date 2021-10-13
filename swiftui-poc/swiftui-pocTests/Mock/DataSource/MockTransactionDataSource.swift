import Foundation
import RxSwift
@testable import swiftui_poc

struct MockTransactionDataSource: TransactionDataSource {
    
    var transactionResponseValue: Single<TransactionResponse>!
    func retrieveTransactions() -> Single<TransactionResponse> {
        return transactionResponseValue
    }
}
