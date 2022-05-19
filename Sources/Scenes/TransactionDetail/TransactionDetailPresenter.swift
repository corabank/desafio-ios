import Foundation

protocol TransactionDetailPresenting: AnyObject {
    func presentContent(transactionDetail: TransactionDetail)
}

final class TransactionDetailPresenter {
    private let coordinator: TransactionDetailCoordinating
    weak var viewController: TransactionDetailDisplaying?

    init(coordinator: TransactionDetailCoordinating) {
        self.coordinator = coordinator
    }
}

extension TransactionDetailPresenter: TransactionDetailPresenting {
    func presentContent(transactionDetail: TransactionDetail) {
        let viewModel = TransactionDetailViewModel(transactionDetail: transactionDetail)
        viewController?.displayContent(viewModel: viewModel)
    }
}
