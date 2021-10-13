import Foundation
import RxSwift

protocol TransactionDataSource {
    func retrieveTransactions() -> Single<TransactionResponse>
}
