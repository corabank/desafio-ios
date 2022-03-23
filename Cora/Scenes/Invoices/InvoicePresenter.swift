final class InvoicePresenter: InvoicePresenterType {
    private let repository = TransactionRepository()
    private let adapter: InvoiceAdapterType = InvoiceAdapter()
    weak var controller: InvoiceControllerType?

    func loadTransactions() {
        repository.getTransactions { [weak self] result in
            if case let .success(transactions) = result {
                self?.controller?.showTransactions(transactions: self?.adapter.adapt(models: transactions) ?? [])
            }
        }
    }
}
