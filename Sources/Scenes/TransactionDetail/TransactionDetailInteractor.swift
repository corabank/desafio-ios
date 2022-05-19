import Foundation

protocol TransactionDetailInteracting: AnyObject {
    func fetchContent()
}

final class TransactionDetailInteractor {
    private let service: TransactionDetailServicing
    private let presenter: TransactionDetailPresenting
    private let transactionId: Int

    init(service: TransactionDetailServicing, presenter: TransactionDetailPresenting, transactionId: Int) {
        self.service = service
        self.presenter = presenter
        self.transactionId = transactionId
    }
}

extension TransactionDetailInteractor: TransactionDetailInteracting {
    func fetchContent() {
        guard let transactionDetail = service.getTransactionDetailData(id: transactionId) else { return }
        presenter.presentContent(transactionDetail: transactionDetail)
    }
}
