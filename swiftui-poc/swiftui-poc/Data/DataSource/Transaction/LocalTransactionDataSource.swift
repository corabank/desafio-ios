import Foundation
import RxSwift

struct LocalTransactionDataSource: TransactionDataSource {

    private let manager: LocalFileReader

    private let file = "transactions"
    private let ext = "json"

    init(manager: LocalFileReader) {
        self.manager = manager
    }

    func retrieveTransactions() -> Single<TransactionResponse> {
        let response: Single<TransactionResponse> = self.manager.read(file: self.file, extension: self.ext)
        return response
    }
}
