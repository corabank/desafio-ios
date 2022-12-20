import UIKit

protocol TransactionDetailPresenting: AnyObject {
    func presentContent(transactionDetail: TransactionDetail)
    func presentActivityController(shareItem: UIImage)
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
    
    func presentActivityController(shareItem: UIImage) {
        coordinator.coordinateToActivityController(shareItem: shareItem)
    }
}
