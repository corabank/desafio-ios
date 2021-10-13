import Foundation
import RxSwift

protocol TransactionRepository {
    func retrieveTransactions() -> Single<TransactionResponse>
}
