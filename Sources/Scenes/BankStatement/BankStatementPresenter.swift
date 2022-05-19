protocol BankStatementPresenting: AnyObject {
    func presentTransactions()
    func presentTransactionDetail(id: Int)
}

final class BankStatementPresenter {
    private let coordinator: BankStatementCoordinating
    weak var viewController: BankStatementDisplaying?

    init(coordinator: BankStatementCoordinating) {
        self.coordinator = coordinator
    }
}

extension BankStatementPresenter: BankStatementPresenting {
    func presentTransactions() {
        viewController?.displayTransactions()
    }
    
    func presentTransactionDetail(id: Int) {
        coordinator.coordinateToTransactionDetail(id: id)
    }
}
