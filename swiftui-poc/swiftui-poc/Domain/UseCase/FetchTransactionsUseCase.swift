import Foundation
import RxSwift

class FetchTransactionsUseCase: SingleUseCase {
    
    typealias Params = Void
    typealias Model = [TransactionModel]
    
    private let repository: TransactionRepository
    
    init(repository: TransactionRepository) {
        self.repository = repository
    }
    
    func execute(with params: Void? = nil) -> Single<[TransactionModel]> {
        return self.repository.retrieveTransactions()
            .map { response in
                response.transactions.map { TransactionModel(mapping: $0) }
            }.map { transactions in
                transactions.filter { $0.status != .unkown && $0.paymentMethod != .unkown }
            }
    }
}
