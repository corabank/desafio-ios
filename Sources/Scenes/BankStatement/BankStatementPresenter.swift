protocol BankStatementPresenting: AnyObject {
    func presentTransactions()
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
}
