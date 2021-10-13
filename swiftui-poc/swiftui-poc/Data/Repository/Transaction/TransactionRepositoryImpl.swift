import Foundation
import RxSwift

struct TransactionRepositoryImpl: TransactionRepository {
    
    private let dataSource: TransactionDataSource
    
    init(dataSource: TransactionDataSource) {
        self.dataSource = dataSource
    }
    
    func retrieveTransactions() -> Single<TransactionResponse> {
        return self.dataSource.retrieveTransactions()
    }
}
