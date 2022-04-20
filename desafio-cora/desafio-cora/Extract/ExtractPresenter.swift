import Foundation

protocol ExtractPresenting: AnyObject {
    var viewController: ExtractDisplaying? { get set }
    func displayStatementList()
    func didNextStep(action: ExtractAction)
    func presentExtractDetail(transaction: TransactionDetail, transactionDay: String)
}

final class ExtractPresenter {
    private let coordinator: ExtractCoordinating
    weak var viewController: ExtractDisplaying?

    init(coordinator: ExtractCoordinating) {
        self.coordinator = coordinator
    }
}

// MARK: - ExtractPresenting
extension ExtractPresenter: ExtractPresenting {
    func presentExtractDetail(transaction: TransactionDetail, transactionDay: String) {
        coordinator.coordinateToExtractDetail(transaction: transaction, transactionDay: transactionDay)
    }
    
    func displayStatementList() {
        viewController?.showStatementList()
    }
    
    func didNextStep(action: ExtractAction) {
        coordinator.perform(action: action)
    }
}
