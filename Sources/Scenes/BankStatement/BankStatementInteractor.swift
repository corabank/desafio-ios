protocol BankStatementInteracting: AnyObject {
    func doSomething()
}

final class BankStatementInteractor {
    private let service: BankStatementServicing
    private let presenter: BankStatementPresenting

    init(service: BankStatementServicing, presenter: BankStatementPresenting) {
        self.service = service
        self.presenter = presenter
    }
}

// MARK: - BankStatementInteracting
extension BankStatementInteractor: BankStatementInteracting {
    func doSomething() {
        presenter.displaySomething()
    }
}
